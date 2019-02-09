module Components.Form exposing (Model, Msg, field, fieldValue, fieldset, form, formGroup, init, legend, onInput, update)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model f =
    { valid : Bool
    , dirty : Bool
    , submitted : Bool
    , fields : List ( f, FieldInfo )
    }


type alias FieldInfo =
    { value : String
    , valid : Bool
    }


init : Model f
init =
    { valid = False
    , dirty = False
    , submitted = False
    , fields = []
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


upsertFieldValue : f -> String -> List ( f, FieldInfo ) -> List ( f, FieldInfo )
upsertFieldValue f val fields =
    let
        ( found_, fields_ ) =
            listReplace
                (\( f_, _ ) -> f_ == f)
                (\( f_, fi ) -> ( f_, { fi | value = val } ))
                fields
    in
    case found_ of
        True ->
            fields_

        False ->
            ( f, FieldInfo val False ) :: fields_


update : Msg f -> Model f -> ( Model f, Cmd (Msg f) )
update msg model =
    case msg of
        OnInput f str ->
            ( { model | dirty = True, fields = upsertFieldValue f str model.fields }, Cmd.none )


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
