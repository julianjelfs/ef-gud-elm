module Stories.Radio exposing (view)

import Components.Radio as R
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


radioStates : Html msg
radioStates =
    div
        []
        [ div [ class "u-mb-m" ]
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


radioGroup : Html msg
radioGroup =
    R.radioGroup "demo"
        [ R.namedRadio [ R.checked ] [ text "Select" ]
        , R.namedRadio [] [ text "a" ]
        , R.namedRadio [] [ text "single" ]
        , R.namedRadio [] [ text "option" ]
        ]


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "This is the radio component" ]
        , radioStates
        , br [] []
        , h5 [] [ text "This is a radio group" ]
        , radioGroup
        ]
