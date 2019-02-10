module Components.Form exposing
    ( Model
    , Msg
    , and
    , field
    , fieldError
    , fieldValid
    , fieldValue
    , fieldset
    , form
    , formGroup
    , init
    , initField
    , legend
    , maxLength
    , onInput
    , or
    , required
    , update
    , validationMessage
    )

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (appendIf, catMaybes)


type alias Model f =
    { valid : Bool
    , dirty : Bool
    , submitted : Bool
    , fields : List ( f, FieldInfo )
    }


type alias FieldInfo =
    { value : String
    , valid : Bool
    , validator : String -> Maybe String
    }


type Validator
    = Validator (String -> Maybe String)



-- validator combinators


and : Validator -> Validator -> Validator
and (Validator a) (Validator b) =
    Validator
        (\s ->
            let
                errs =
                    catMaybes [ a s, b s ]
            in
            if List.isEmpty errs then
                Nothing

            else
                Just (errs |> String.join ", ")
        )


or : Validator -> Validator -> Validator
or (Validator a) (Validator b) =
    Validator
        (\s ->
            Maybe.map2
                (\a_ b_ ->
                    a_ ++ ", " ++ b_
                )
                (a s)
                (b s)
        )


required : Validator
required =
    Validator
        (\s ->
            if s == "" then
                Just "You must enter this field"

            else
                Nothing
        )


maxLength : Int -> Validator
maxLength n =
    Validator
        (\s ->
            if String.length s > n then
                Just <| "Max length is " ++ String.fromInt n

            else
                Nothing
        )


type Field f
    = Field ( f, FieldInfo )


initField : f -> Validator -> Field f
initField f (Validator fn) =
    Field ( f, FieldInfo "" (fn "" == Nothing) fn )


init : List (Field f) -> Model f
init fields =
    let
        m =
            { valid = False
            , dirty = False
            , submitted = False
            , fields = List.map (\(Field fi) -> fi) fields
            }
    in
    { m | valid = formValid m }


type Msg f
    = OnInput f String


onInput : f -> String -> Msg f
onInput =
    OnInput


listReplace : (a -> Bool) -> (a -> a) -> List a -> ( Bool, List a )
listReplace pred map =
    List.foldr
        (\x ( found, list_ ) ->
            if pred x then
                ( True, map x :: list_ )

            else
                ( found, x :: list_ )
        )
        ( False, [] )


fieldValue : f -> Model f -> Maybe String
fieldValue =
    propertyOfFieldInfo .value


fieldValid : f -> Model f -> Bool
fieldValid f m =
    propertyOfFieldInfo .valid f m |> Maybe.withDefault True


fieldError : f -> Model f -> Maybe String
fieldError f m =
    propertyOfFieldInfo identity f m
        |> Maybe.andThen (\fi -> fi.validator fi.value)


propertyOfFieldInfo : (FieldInfo -> a) -> f -> Model f -> Maybe a
propertyOfFieldInfo prop f { fields } =
    fields
        |> List.filter (\( f_, _ ) -> f_ == f)
        |> List.map (\( _, fi ) -> prop fi)
        |> List.head


updateFieldInfo : String -> FieldInfo -> FieldInfo
updateFieldInfo val fi =
    { fi | value = val, valid = fi.validator val == Nothing }


upsertFieldValue : f -> String -> List ( f, FieldInfo ) -> List ( f, FieldInfo )
upsertFieldValue f val fields =
    let
        ( found_, fields_ ) =
            listReplace
                (\( f_, _ ) -> f_ == f)
                (\( f_, fi ) -> ( f_, updateFieldInfo val fi ))
                fields
    in
    case found_ of
        True ->
            fields_

        False ->
            ( f, FieldInfo val False (always Nothing) ) :: fields_


update : Msg f -> Model f -> ( Model f, Cmd (Msg f) )
update msg model =
    case msg of
        OnInput f str ->
            let
                fields =
                    upsertFieldValue f str model.fields
            in
            ( { model
                | dirty = True
                , valid = formValid { model | fields = fields }
                , fields = fields
              }
            , Cmd.none
            )


form : List (Html (Msg f)) -> Html (Msg f)
form children =
    Html.form
        [ class "ef-form" ]
        children


validationMessage : f -> Model f -> Html (Msg f)
validationMessage f m =
    fieldError f m
        |> Maybe.map
            (\err ->
                div
                    [ class "ef-form-validation -is-invalid" ]
                    [ text err ]
            )
        |> Maybe.withDefault (text "")


field : Maybe String -> Html (Msg f) -> Html (Msg f)
field label control =
    let
        lbl =
            Maybe.map (\l -> Html.label [ class "ef-form-label" ] [ text l ]) label
                |> Maybe.withDefault (text "")
    in
    div
        []
        (lbl
            :: control
            :: [ div [ class "ef-form-validation" ]
                    [ text "this is the validation message" ]
               ]
        )


type Legend f
    = Legend (Html (Msg f))


legend : String -> Legend f
legend txt =
    Legend <| Html.legend [ class "ef-form-label" ] [ text txt ]


fieldset : Legend f -> List (Html (Msg f)) -> Html (Msg f)
fieldset (Legend l) children =
    Html.fieldset
        [ class "ef-form-fieldset u-mb-m" ]
        (l :: children)


groupValid : List f -> Model f -> Bool
groupValid fs m =
    List.foldr
        (\f v ->
            fieldValid f m && v
        )
        True
        fs


formValid : Model f -> Bool
formValid m =
    List.foldr
        (\( f, _ ) v ->
            fieldValid f m && v
        )
        True
        m.fields


formGroup : List f -> Model f -> List (Html (Msg f)) -> Html (Msg f)
formGroup fs model children =
    div
        ([ class "ef-form-group" ] |> appendIf (not <| groupValid fs model) (class "-is-invalid"))
        children
