module Components.Form exposing (Model, Msg, field, fieldset, form, formGroup, init, legend, onInput, update)

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { valid : Bool
    , dirty : Bool
    , submitted : Bool
    }


init : Model
init =
    { valid = False
    , dirty = False
    , submitted = False
    }


type Msg
    = OnInput String


onInput : String -> Msg
onInput =
    OnInput


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput str ->
            let
                _ =
                    Debug.log "FormInput" str
            in
            ( model, Cmd.none )


form : Model -> List (Html Msg) -> Html Msg
form model children =
    Html.form
        [ class "ef-form" ]
        children


field : Maybe String -> Html Msg -> Html Msg
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


type Legend
    = Legend (Html Msg)


legend : String -> Legend
legend txt =
    Legend <| Html.legend [ class "ef-form-label" ] [ text txt ]


fieldset : Legend -> List (Html Msg) -> Html Msg
fieldset (Legend l) children =
    Html.fieldset
        [ class "ef-form-fieldset u-mb-m" ]
        (l :: children)


formGroup : List (Html Msg) -> Html Msg
formGroup children =
    div
        []
        children
