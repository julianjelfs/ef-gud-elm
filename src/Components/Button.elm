module Components.Button exposing
    ( ButtonProps
    , ButtonShape(..)
    , ButtonSize(..)
    , ButtonType(..)
    , buttonComponent
    , defaultProps
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type ButtonType
    = Primary
    | Secondary


type ButtonShape
    = Rounded
    | Square


type ButtonSize
    = Default
    | Small


type ButtonShadow
    = PrimaryDefault
    | PrimaryHover
    | PrimaryFocus
    | PrimaryFocusHover
    | SecondaryDefault
    | SecondaryHover
    | SecondaryFocus
    | SecondaryFocusHover


type alias ButtonProps msg =
    { text : String
    , onClick : Maybe msg
    , buttonType : ButtonType
    , shape : ButtonShape
    , isLoading : Bool
    , size : ButtonSize
    , disabled : Bool
    , accessKey : Maybe String
    , tabIndex : Maybe Int
    , grouped : Bool
    , hover : Bool
    , active : Bool
    , focus : Bool
    , loading : Bool
    }


defaultProps : ButtonProps msg
defaultProps =
    { text = "Click"
    , onClick = Nothing
    , buttonType = Primary
    , shape = Rounded
    , isLoading = False
    , size = Default
    , disabled = False
    , accessKey = Nothing
    , tabIndex = Nothing
    , grouped = False
    , hover = False
    , active = False
    , focus = False
    , loading = False
    }


buttonComponent : ButtonProps msg -> Html msg
buttonComponent props =
    button
        ([ class "ef-button"
         , type_ "button"
         , disabled props.disabled
         , classList
            [ ( "-primary", props.buttonType == Primary )
            , ( "-secondary", props.buttonType == Secondary )
            , ( "-active", props.active )
            , ( "-hover", props.hover )
            , ( "-focus", props.focus )
            , ( "-is-loading", props.loading )
            , ( "-square", props.shape == Square )
            , ( "-small", props.size == Small )
            ]
         ]
            |> maybeAppend (Maybe.map onClick props.onClick)
        )
        [ span [ class "ef-button__content" ] [ text props.text ] ]
