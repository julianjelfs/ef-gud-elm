module Stories.Input exposing (Model, Msg, init, update, view)

import Components.Input as I
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S


type alias Model =
    { text : String }


type Msg
    = OnInput String


init : Model
init =
    { text = "" }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput str ->
            ( { model | text = str }, Cmd.none )


exampleInput : List (I.InputProp Msg) -> Html Msg
exampleInput props =
    I.input (I.onInput OnInput :: I.verticalMargin S.Medium :: props)


inputTypes : Model -> List (Html Msg)
inputTypes model =
    [ div [] [ I.input [ I.placeholder "type: text" ] ]
    , div []
        [ code [] [ text model.text ] ]
    , div []
        [ exampleInput [ I.placeholder "type: email", I.type_ I.EmailInput ] ]
    , div []
        [ exampleInput [ I.placeholder "type: number", I.type_ I.NumberInput ] ]
    , div []
        [ exampleInput [ I.placeholder "type: password", I.type_ I.PasswordInput ] ]
    , div []
        [ exampleInput [ I.placeholder "type: search", I.type_ I.SearchInput ] ]
    , div []
        [ exampleInput [ I.placeholder "type: tel", I.type_ I.TelInput ] ]
    , div []
        [ exampleInput [ I.placeholder "type: url", I.type_ I.UrlInput ] ]
    ]


inputStates : List (Html Msg)
inputStates =
    [ div []
        [ exampleInput [ I.placeholder "untouched" ] ]
    , div []
        [ exampleInput
            [ I.placeholder "focused", I.focus ]
        ]
    , div []
        [ exampleInput
            [ I.value "completed", I.completed ]
        ]
    , div []
        [ exampleInput
            [ I.placeholder "disabled", I.disabled ]
        ]
    , div []
        [ exampleInput
            [ I.value "valid", I.valid ]
        ]
    , div []
        [ exampleInput
            [ I.value "invalid", I.invalid ]
        ]
    , div []
        [ exampleInput
            [ I.placeholder "loading", I.loading ]
        ]
    ]


view : Model -> Html Msg
view model =
    div
        []
        ([ h3 [] [ text "This is the input component" ]
         ]
            ++ [ h5 [] [ text "These are the input types" ] ]
            ++ inputTypes model
            ++ [ br [] [], h5 [] [ text "These are the interaction states" ] ]
            ++ inputStates
        )
