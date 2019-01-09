module Components.Button exposing
    ( ButtonProps
    , ButtonShape(..)
    , ButtonSize(..)
    , buttonComponent
    , defaultProps
    , story
    )

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, disabled, href, src)
import Html.Styled.Events exposing (onClick)
import Theme exposing (theme)


type ButtonType
    = Primary
    | Secondary


type ButtonShape
    = Rounded
    | Square


type ButtonSize
    = Default
    | Small


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


concatIf : Bool -> List Style -> List Style -> List Style
concatIf pred toAppend appendTo =
    case pred of
        True ->
            appendTo ++ toAppend

        False ->
            appendTo


maybeAppend : Maybe a -> List a -> List a
maybeAppend m l =
    case m of
        Just x ->
            l ++ [ x ]

        Nothing ->
            l


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
             ]
                |> List.append (buttonDimensions props.shape props.size)
                |> concatIf props.disabled disabledStyles
            )
         ]
            |> maybeAppend (Maybe.map onClick props.onClick)
        )
        [ text props.text ]


story : ButtonProps msg -> Html msg
story =
    buttonComponent
