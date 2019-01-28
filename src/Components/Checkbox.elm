module Components.Checkbox exposing
    ( CheckboxProps
    , CheckboxValidity(..)
    , checkbox
    , defaultProps
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


defaultProps : CheckboxProps msg
defaultProps =
    { checked = False
    , label = ""
    , focus = False
    , disabled = False
    , validity = Neither
    , onInput = Nothing
    }


type alias CheckboxProps msg =
    { checked : Bool
    , label : String
    , focus : Bool
    , disabled : Bool
    , validity : CheckboxValidity
    , onInput : Maybe (String -> msg)
    }


type CheckboxValidity
    = Valid
    | Invalid
    | Neither


checkbox : CheckboxProps msg -> Html msg
checkbox props =
    label
        [ class "ef-input-w ef-boolean"
        , classList
            [ ( "-is-valid", props.validity == Valid )
            , ( "-is-invalid", props.validity == Invalid )
            ]
        ]
        [ input
            [ class "ef-boolean__input"
            , classList
                [ ( "-focus", props.focus )
                ]
            , type_ "checkbox"
            , checked props.checked
            , disabled props.disabled
            ]
            []
        , span [ class "ef-boolean__element -checkbox" ] []
        , span [ class "ef-boolean__label" ] [ text props.label ]
        ]
