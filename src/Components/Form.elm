module Components.Form exposing
    ( Model
    , Msg
    , and
    , field
    , fieldValue
    , fieldset
    , form
    , formGroup
    , init
    , initField
    , legend
    , maxLength
    , onInput
    , required
    , update
    )

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (catMaybes)


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
    { valid = False
    , dirty = False
    , submitted = False
    , fields = List.map (\(Field fi) -> fi) fields
    }


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
fieldValue f { fields } =
    fields
        |> List.filter (\( f_, _ ) -> f_ == f)
        |> List.map (\( _, { value } ) -> value)
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
                , valid = True
                , fields = fields
              }
            , Cmd.none
            )


form : Model f -> List (Html (Msg f)) -> Html (Msg f)
form model children =
    Html.form
        [ class "ef-form" ]
        children


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


formGroup : List (Html (Msg f)) -> Html (Msg f)
formGroup children =
    div
        []
        children
