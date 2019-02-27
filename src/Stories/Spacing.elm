module Stories.Spacing exposing (view)

import Breakpoint as BP
import Grid as G
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Stories.Utils exposing (..)
import Template as Template
import Typography as T


outer attrs =
    div
        (class "spacing-box" :: attrs)


allTags sz mod =
    { defaultTags
        | stag = Just <| "u-s-" ++ mod ++ "-" ++ sz
        , mtag = Just <| "u-m-" ++ mod ++ "-" ++ sz
        , ltag = Just <| "u-l-" ++ mod ++ "-" ++ sz
        , xltag = Just <| "u-xl-" ++ mod ++ "-" ++ sz
    }


padding : S.Modifier -> String -> List (Html msg)
padding mod modStr =
    [ outer
        [ S.spacing Nothing S.Padding mod S.Zero ]
        [ box (allTags "0" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.ExtraExtraSmall ]
        [ box (allTags "xxs" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.ExtraSmall ]
        [ box (allTags "xs" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.Small ]
        [ box (allTags "s" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.Medium ]
        [ box (allTags "m" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.Large ]
        [ box (allTags "l" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.ExtraLarge ]
        [ box (allTags "xl" modStr) ]
    , outer
        [ S.spacing Nothing S.Padding mod S.ExtraExtraLarge ]
        [ box (allTags "xxl" modStr) ]
    ]


margin : S.Modifier -> String -> List (Html msg)
margin mod modStr =
    [ div
        [ S.spacing Nothing S.Margin mod S.Zero ]
        [ box (allTags "0" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.ExtraExtraSmall ]
        [ box (allTags "xxs" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.ExtraSmall ]
        [ box (allTags "xs" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.Small ]
        [ box (allTags "s" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.Medium ]
        [ box (allTags "m" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.Large ]
        [ box (allTags "l" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.ExtraLarge ]
        [ box (allTags "xl" modStr) ]
    , div
        [ S.spacing Nothing S.Margin mod S.ExtraExtraLarge ]
        [ box (allTags "xxl" modStr) ]
    ]


view : Html msg
view =
    div
        [ class "spacing-docs" ]
        [ T.h4 [] [ text "Spacing Utilities" ]
        , T.para [ T.light ] [ text "We provide utility functions to modify container's spacing according to GUD breakpoints and spacing scales. Where appropriate there are also helpers for each component type that supports custom spacing" ]
        , T.h5 [] [ text "Padding all round" ]
        , div [] (padding S.All "p")
        , T.h5 [] [ text "Padding top and bottom" ]
        , G.row []
            [ G.col [] (padding S.Top "pt")
            , G.col [] (padding S.Bottom "pb")
            ]
        , T.h5 [] [ text "Padding left and right" ]
        , G.row []
            [ G.col [] (padding S.Left "pl")
            , G.col [] (padding S.Right "pr")
            ]
        , T.h5 [] [ text "Margin all round" ]
        , div [] (margin S.All "m")
        , T.h5 [] [ text "Margin top and bottom" ]
        , G.row []
            [ G.col [] (margin S.Top "mt")
            , G.col [] (margin S.Bottom "mb")
            ]
        , br [] []
        , T.h5 [] [ text "Margin left and right" ]
        , G.row []
            [ G.col [] (margin S.Left "ml")
            , G.col [] (margin S.Right "mr")
            ]
        ]
