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
        , Css.lineHeight (px 96)
        , Css.margin auto
        ]


wrapperStyle : Style
wrapperStyle =
    Css.batch
        [ Css.maxWidth (px 96)
        , Css.maxHeight (px 104)
        ]


textStyle : Style
textStyle =
    Css.batch
        [ Css.position relative
        , Css.top (px 32)
        , Css.left (px 32)
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


getInitials : String -> String
getInitials name =
    String.split " " name
        |> List.map (String.slice 0 1)
        |> List.map String.toUpper
        |> String.join ""


profileInitial : String -> Html msg
profileInitial name =
    div
        [ css [ outerStyle ] ]
        [ div
            [ css [ wrapperStyle ] ]
            [ div [ css [ textStyle ] ] [ Html.Styled.fromUnstyled <| T.h4 [] [ Unstyled.text (getInitials name) ] ]
            , div
                [ css [ boxShadowStyle ] ]
                []
            ]
        ]
