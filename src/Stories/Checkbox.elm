module Stories.Checkbox exposing (view)

import Checkbox as C
import Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "This is the checkbox component" ]
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
