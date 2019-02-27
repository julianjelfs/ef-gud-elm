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
        [ S.padding Nothing mod S.Zero ]
        [ box (allTags "0" modStr) ]
    , outer
        [ S.padding Nothing mod S.ExtraExtraSmall ]
        [ box (allTags "xxs" modStr) ]
    , outer
        [ S.padding Nothing mod S.ExtraSmall ]
        [ box (allTags "xs" modStr) ]
    , outer
        [ S.padding Nothing mod S.Small ]
        [ box (allTags "s" modStr) ]
    , outer
        [ S.padding Nothing mod S.Medium ]
        [ box (allTags "m" modStr) ]
    , outer
        [ S.padding Nothing mod S.Large ]
        [ box (allTags "l" modStr) ]
    , outer
        [ S.padding Nothing mod S.ExtraLarge ]
        [ box (allTags "xl" modStr) ]
    , outer
        [ S.padding Nothing mod S.ExtraExtraLarge ]
        [ box (allTags "xxl" modStr) ]
    ]


margin : S.Modifier -> String -> List (Html msg)
margin mod modStr =
    [ div
        [ S.margin Nothing mod S.Zero ]
        [ box (allTags "0" modStr) ]
    , div
        [ S.margin Nothing mod S.ExtraExtraSmall ]
        [ box (allTags "xxs" modStr) ]
    , div
        [ S.margin Nothing mod S.ExtraSmall ]
        [ box (allTags "xs" modStr) ]
    , div
        [ S.margin Nothing mod S.Small ]
        [ box (allTags "s" modStr) ]
    , div
        [ S.margin Nothing mod S.Medium ]
        [ box (allTags "m" modStr) ]
    , div
        [ S.margin Nothing mod S.Large ]
        [ box (allTags "l" modStr) ]
    , div
        [ S.margin Nothing mod S.ExtraLarge ]
        [ box (allTags "xl" modStr) ]
    , div
        [ S.margin Nothing mod S.ExtraExtraLarge ]
        [ box (allTags "xxl" modStr) ]
    ]


view : Html msg
view =
    div
        [ class "spacing-docs" ]
        [ T.h4 [] [ text "Spacing Utilities" ]
        , T.para [ T.light ] [ text "We provide utility functions to modify container's spacing according to GUD breakpoints and spacing scales. Where appropriate there are also helpers for each component type that supports custom spacing" ]
        , T.para [ T.light ] [ text "This is achieved using the Spacing.padding and Spacing.margin functions to apply attributes directly to elm html nodes or by using the corresponding padding and margin functions on the relevant components. In each case the signature is the same" ]
        , code []
            [ text "padding : Maybe BP.Breakpoint -> Modifier -> Spacing -> Attribute msg" ]
        , br [] []
        , code []
            [ text "margin : Maybe BP.Breakpoint -> Modifier -> Spacing -> Attribute msg" ]
        , div [ S.margin Nothing S.Top S.Large ] []
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
