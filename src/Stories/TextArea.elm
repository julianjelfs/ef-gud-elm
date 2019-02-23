module Stories.TextArea exposing (Model, Msg, init, update, view)

import Components.TextArea as T
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


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


exampleTextArea : List (T.TextAreaProp Msg) -> Html Msg
exampleTextArea props =
    T.textarea (T.onInput OnInput :: props)


textAreaStates : Model -> List (Html Msg)
textAreaStates model =
    [ div []
        [ code [] [ text model.text ]
        , exampleTextArea [ T.placeholder "untouched" ]
        ]
    , div []
        [ exampleTextArea
            [ T.placeholder "focused", T.focus ]
        ]
    , div []
        [ exampleTextArea
            [ T.value "completed", T.completed ]
        ]
    , div []
        [ exampleTextArea
            [ T.placeholder "disabled", T.disabled ]
        ]
    , div []
        [ exampleTextArea
            [ T.value "valid", T.valid ]
        ]
    , div []
        [ exampleTextArea
            [ T.value "invalid", T.invalid ]
        ]
    , div []
        [ exampleTextArea
            [ T.placeholder "loading", T.loading ]
        ]
    ]


view : Model -> Html Msg
view model =
    div
        []
        ([ T.h4 [] [ text "This is the textarea component" ]
         ]
            ++ textAreaStates model
        )
