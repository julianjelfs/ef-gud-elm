module ProfileInitial exposing (profileInitial)

import Css exposing (..)
import Html as Unstyled
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Typography as T


outerStyle : Style
outerStyle =
    Css.batch
        [ Css.width (px 96)
        , Css.height (px 96)
        , Css.borderRadius (pct 50)
        , Css.backgroundImage <| Css.linearGradient2 (deg 225) (stop <| hex "ffa9d5") (stop <| hex "c4d4ff") []
        , Css.alignItems center
        , Css.justifyContent center
        , Css.display Css.inlineFlex
        , Css.lineHeight (px 96)
        ]


wrapperStyle : Style
wrapperStyle =
    Css.batch
        [ Css.maxWidth (px 96)
        , Css.maxHeight (px 104)
        , Css.margin auto
        ]


textStyle : Style
textStyle =
    Css.batch
        [ Css.position relative
        , Css.top (px 30)
        , Css.left (px 28)
        ]


boxShadowStyle : Style
boxShadowStyle =
    Css.batch
        [ Css.width (px 88)
        , Css.height (px 75)
        , Css.borderRadius (px 45.5)
        , Css.transform (Css.rotate (deg 61))
        , Css.property "filter" "blur(10px)"
        , Css.backgroundImage <| Css.linearGradient2 (deg 219) (stop <| hex "f854a7") (stop <| hex "205cff") []
        , Css.position Css.relative
        , Css.bottom (px 34)
        , Css.zIndex (int -1)
        ]


profileInitial : String -> Unstyled.Html msg
profileInitial name =
    toUnstyled <|
        div
            [ css [ outerStyle ] ]
            [ div
                [ css [ wrapperStyle ] ]
                [ div [ css [ textStyle ] ] [ Html.Styled.fromUnstyled <| T.h4 [] [ Unstyled.text name ] ]
                , div
                    [ css [ boxShadowStyle ] ]
                    []
                ]
            ]
