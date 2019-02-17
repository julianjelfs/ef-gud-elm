module Stories.Switch exposing (Model, Msg, init, update, view)

import Components.Switch as S
import Components.Typography as T
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


large : Html Msg
large =
    div
        []
        [ T.h4 [] [ text "... or large" ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large ] [ text "default" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.checked ] [ text "checked" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.focus ] [ text "focused" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.disabled ] [ text "disabled" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.disabled, S.checked ] [ text "disabled and checked" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.invalid ] [ text "invalid" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.large, S.invalid, S.checked ] [ text "invalid and checked" ] ]
        ]


small : Html Msg
small =
    div
        []
        [ T.h4 [] [ text "Which can be small ..." ]
        , div [ class "u-mb-m" ]
            [ S.switch [] [ text "default" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.checked ] [ text "checked" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.focus ] [ text "focused" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.disabled ] [ text "disabled" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.disabled, S.checked ] [ text "disabled and checked" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.invalid ] [ text "invalid" ] ]
        , div [ class "u-mb-m" ]
            [ S.switch [ S.invalid, S.checked ] [ text "invalid and checked" ] ]
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [] [ text "This is the switch component" ]
        , small
        , large
        ]
