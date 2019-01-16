module Components.Button exposing
    ( ButtonProps
    , ButtonShape(..)
    , ButtonSize(..)
    , buttonComponent
    , defaultProps
    )

import Html exposing (..)
import Html.Attributes exposing (disabled, href, src)
import Html.Events exposing (onClick)
import Theme exposing (Theme, theme)
import Utils exposing (concatIf, maybeAppend)


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
    }


buttonComponent : ButtonProps msg -> Html msg
buttonComponent props =
    button
        []
        [ text props.text ]
