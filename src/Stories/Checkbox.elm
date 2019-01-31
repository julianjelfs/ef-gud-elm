module Stories.Checkbox exposing (Model, Msg, init, update, view)

import Components.Checkbox as C
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
        [ h3 [] [ text "This is the checkbox component" ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [] [ text "default" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.checked ] [ text "checked" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.focus ] [ text "focused" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.disabled ] [ text "disabled" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.disabled, C.checked ] [ text "disabled and checked" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.invalid ] [ text "invalid" ] ]
        , div [ class "u-mb-m" ]
            [ C.checkbox [ C.invalid, C.checked ] [ text "invalid and checked" ] ]
        ]
