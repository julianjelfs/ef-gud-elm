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
    , matches
    , maxLength
    , nullValidator
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
import Regex as Rx
import Utils exposing (appendIf, catMaybes)


{-| This is totally out of control, needs a re-think
Capabilities of the form

  - track a collection of fields
  - retrieve the value of a field (generically)
  - constrain the type of the field and the type of the value
  - report the validity of the field

-}
type alias Model f v =
    { valid : Bool
    , dirty : Bool
    , submitted : Bool
    , fields : List ( f, FieldInfo v )
    }


type alias FieldInfo v =
    { value : v
    , valid : Bool
    , validator : v -> Maybe String
    }


type Validator v
    = Validator (v -> Maybe String)


{-| validator combinators
-}
and : Validator v -> Validator v -> Validator v
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


or : Validator v -> Validator v -> Validator v
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


nullValidator : Validator v
nullValidator =
    Validator (\s -> Nothing)


validator : (v -> Maybe String) -> (String -> Maybe String) -> Validator v
validator toString fn =
    Validator <|
        \v ->
            case toString v of
                Nothing ->
                    Nothing

                Just s ->
                    fn s


matches : Rx.Regex -> (v -> Maybe String) -> Validator v
matches re toString =
    validator toString <|
        \s ->
            case Rx.find re s of
                [] ->
                    Just "Field did not match the supplied regex and yes this message sucks"

                _ ->
                    Nothing


required : (v -> Maybe String) -> Validator v
required toString =
    validator toString <|
        \s ->
            if s == "" then
                Just "You must enter this field"

            else
                Nothing


maxLength : Int -> (v -> Maybe String) -> Validator v
maxLength n toString =
    validator toString <|
        \s ->
            if String.length s > n then
                Just <| "Max length is " ++ String.fromInt n

            else
                Nothing


type Field f v
    = Field ( f, FieldInfo v )


initField : f -> v -> Validator v -> Field f v
initField f initial (Validator fn) =
    Field ( f, FieldInfo initial (fn initial == Nothing) fn )


init : List (Field f v) -> Model f v
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


type Msg f v
    = OnInput f v


onInput : f -> v -> Msg f v
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


fieldValue : f -> Model f v -> Maybe v
fieldValue =
    propertyOfFieldInfo .value


fieldValid : f -> Model f v -> Bool
fieldValid f m =
    propertyOfFieldInfo .valid f m |> Maybe.withDefault True


fieldError : f -> Model f v -> Maybe String
fieldError f m =
    propertyOfFieldInfo identity f m
        |> Maybe.andThen (\fi -> fi.validator fi.value)


propertyOfFieldInfo : (FieldInfo v -> a) -> f -> Model f v -> Maybe a
propertyOfFieldInfo prop f { fields } =
    fields
        |> List.filter (\( f_, _ ) -> f_ == f)
        |> List.map (\( _, fi ) -> prop fi)
        |> List.head


updateFieldInfo : v -> FieldInfo v -> FieldInfo v
updateFieldInfo val fi =
    { fi | value = val, valid = fi.validator val == Nothing }


upsertFieldValue : f -> v -> List ( f, FieldInfo v ) -> List ( f, FieldInfo v )
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


update : Msg f v -> Model f v -> ( Model f v, Cmd (Msg f v) )
update msg model =
    case msg of
        OnInput f val ->
            let
                fields =
                    upsertFieldValue f val model.fields
            in
            ( { model
                | dirty = True
                , valid = formValid { model | fields = fields }
                , fields = fields
              }
            , Cmd.none
            )


form : List (Html (Msg f v)) -> Html (Msg f v)
form children =
    Html.form
        [ class "ef-form" ]
        children


validationMessage : f -> Model f v -> Html (Msg f v)
validationMessage f m =
    fieldError f m
        |> Maybe.map
            (\err ->
                div
                    [ class "ef-form-validation -is-invalid" ]
                    [ text err ]
            )
        |> Maybe.withDefault (text "")


field : Maybe String -> Html (Msg f v) -> Html (Msg f v)
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


type Legend f v
    = Legend (Html (Msg f v))


legend : String -> Legend f v
legend txt =
    Legend <| Html.legend [ class "ef-form-label" ] [ text txt ]


fieldset : Legend f v -> List (Html (Msg f v)) -> Html (Msg f v)
fieldset (Legend l) children =
    Html.fieldset
        [ class "ef-form-fieldset u-mb-m" ]
        (l :: children)


groupValid : List f -> Model f v -> Bool
groupValid fs m =
    List.foldr
        (\f v ->
            fieldValid f m && v
        )
        True
        fs


formValid : Model f v -> Bool
formValid m =
    List.foldr
        (\( f, _ ) v ->
            fieldValid f m && v
        )
        True
        m.fields


formGroup : List f -> Model f v -> List (Html (Msg f v)) -> Html (Msg f v)
formGroup fs model children =
    let
        valid =
            groupValid fs model
    in
    div
        ([ class "ef-form-group" ]
            |> appendIf (not valid) (class "-is-invalid")
            |> appendIf valid (class "-is-valid")
        )
        children
