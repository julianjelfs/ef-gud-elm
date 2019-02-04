module Stories.Radio exposing (Model, Msg, init, update, view)

import Components.Radio as R
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ h3 [] [ text "This is the radio component" ]
        , div [ class "u-mb-m" ]
            [ R.radio [] [ text "default" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.checked ] [ text "checked" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.focus ] [ text "focused" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.disabled ] [ text "disabled" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.disabled, R.checked ] [ text "disabled and checked" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.invalid ] [ text "invalid" ] ]
        , div [ class "u-mb-m" ]
            [ R.radio [ R.invalid, R.checked ] [ text "invalid and checked" ] ]
        ]
