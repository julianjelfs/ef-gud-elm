module Components.Button exposing
    ( ButtonProps
    , ButtonShape(..)
    , ButtonSize(..)
    , buttonComponent
    , defaultProps
    , story
    )

import Css exposing (..)
import Css.Transitions as CT
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, disabled, href, src)
import Html.Styled.Events exposing (onClick)
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


type alias ShadowStyles =
    { borderLight : Style
    , borderNone : Style
    , focusNone : Style
    , focusNoneColor : Style
    , focusShadow : Style
    , focusShadowColor : Style
    , shadowDarkColor : Style
    , shadowLight : Style
    , shadowLightColor : Style
    , shadowMidColor : Style
    , shadowNone : Style
    , shadowNoneColor : Style
    }


constants =
    { lineHeight = 1.2
    , padding =
        { big =
            { vertical = 12
            , horizontal = 25
            }
        , small =
            { vertical = 8
            , horizontal = 12
            }
        }
    , fontSize =
        { big = 14
        , small = 12
        }
    , borderRadius =
        { big = 20
        , small = 4
        }
    }


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


disabledStyles : List Style
disabledStyles =
    [ opacity (num 0.4)
    , boxShadow none
    ]


primaryStyles : ButtonProps msg -> List Style
primaryStyles { disabled } =
    [ zIndex (int 1)
    , before
        [ opacity (num 1) ]
    , borderShadows theme |> .focusNoneColor
    , color theme.colors.text.light
    ]
        |> concatIf (not disabled)
            [ hover
                [ borderShadows theme |> .shadowDarkColor
                , focus [ borderShadows theme |> .shadowDarkColor ]
                ]
            , focus
                [ borderShadows theme |> .shadowMidColor ]
            ]


secondaryStyles : ButtonProps msg -> List Style
secondaryStyles { disabled } =
    [ backgroundColor <| Css.hex "FFFFFF"
    , before
        [ opacity (num 0) ]
    , borderShadows theme |> .shadowNone
    , color theme.colors.text.light
    ]
        |> concatIf (not disabled)
            [ hover
                [ borderShadows theme |> .shadowLight
                , focus [ borderShadows theme |> .shadowLight ]
                ]
            , focus
                [ borderShadows theme |> .shadowNone ]
            ]


buttonDimensions : ButtonShape -> ButtonSize -> List Style
buttonDimensions shape size =
    case size of
        Default ->
            [ padding2 (px constants.padding.big.vertical)
                (px
                    constants.padding.big.horizontal
                )
            , fontSize (px constants.fontSize.big)
            , borderRadius
                (case shape of
                    Rounded ->
                        px constants.borderRadius.big

                    Square ->
                        px constants.borderRadius.small
                )
            ]

        Small ->
            [ padding2 (px constants.padding.small.vertical)
                (px
                    constants.padding.small.horizontal
                )
            , fontSize (px constants.fontSize.small)
            , borderRadius (px constants.borderRadius.small)
            ]



-- Problem: https://github.com/rtfeldman/elm-css/issues/265
-- not possible to do multiple box shadows at the moment with elm-css


borderShadows : Theme -> ShadowStyles
borderShadows theme =
    { borderLight =
        boxShadow6 inset
            (px 0)
            (px 0)
            (px 0)
            (px 1)
            (changeAlpha theme.colors.border.interactive 0.2)
    , borderNone =
        boxShadow6 inset
            (px 0)
            (px 0)
            (px 0)
            (px 0)
            (changeAlpha theme.colors.border.interactive 0.4)
    , focusNone =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (px 0)
            (changeAlpha theme.colors.border.interactive 0.1)
    , focusNoneColor =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (px 0)
            (changeAlpha theme.colors.border.interactive 0.1)
    , focusShadow =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (Css.em 0.25)
            (changeAlpha theme.colors.border.interactive 0.1)
    , focusShadowColor =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (Css.em 0.25)
            (changeAlpha theme.colors.primary 0.3)
    , shadowDarkColor =
        boxShadow4 (px 0)
            (px 4)
            (px 12)
            (changeAlpha theme.colors.primary 0.4)
    , shadowLight =
        boxShadow4 (px 0)
            (px 2)
            (px 4)
            (changeAlpha theme.colors.inkBlack 0.2)
    , shadowLightColor =
        boxShadow4 (px 0)
            (px 2)
            (px 8)
            (changeAlpha theme.colors.primary 0.2)
    , shadowMidColor =
        boxShadow4 (px 0)
            (px 2)
            (px 8)
            (changeAlpha theme.colors.primary 0.2)
    , shadowNone =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (px 0)
            (changeAlpha theme.colors.inkBlack 0.2)
    , shadowNoneColor =
        boxShadow5 (px 0)
            (px 0)
            (px 0)
            (px 0)
            (changeAlpha theme.colors.primary 0.3)
    }


changeAlpha : Css.Color -> Float -> Css.Color
changeAlpha { red, green, blue } =
    \a -> rgba red green blue a


transWhite : Css.Color
transWhite =
    Css.rgba 255 255 255 0.3


buttonComponent : ButtonProps msg -> Html msg
buttonComponent props =
    button
        ([ disabled props.disabled
         , css
            ([ position relative
             , display inlineFlex
             , lineHeight (num constants.lineHeight)
             , border (px 0)
             , padding (px 20)
             , backgroundColor theme.colors.digitalFirstBlue
             , cursor pointer
             , outline none
             , overflow hidden
             , before
                [ display block
                , position absolute
                , top (px 0)
                , right (px 0)
                , bottom (px 0)
                , left (px 0)
                , CT.transition
                    [ CT.opacity3 100.0 0 CT.ease ]
                , opacity (num 1)
                , zIndex (int 0)
                , backgroundImage
                    (linearGradient (stop transWhite) (stop transWhite) [])
                ]
             ]
                |> List.append (buttonDimensions props.shape props.size)
                |> concatIf props.disabled disabledStyles
                |> concatIf (props.buttonType == Primary) (primaryStyles props)
                |> concatIf (props.buttonType == Secondary) (secondaryStyles props)
            )
         ]
            |> maybeAppend (Maybe.map onClick props.onClick)
        )
        [ text props.text ]


story : ButtonProps msg -> Html msg
story =
    buttonComponent
