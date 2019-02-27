module Spacing exposing
    ( Modifier(..)
    , Spacing(..)
    , SpacingType(..)
    , margin
    , padding
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)


type Modifier
    = Bottom
    | Left
    | Right
    | All
    | Top
    | Vertical
    | Horizontal


type Spacing
    = Zero
    | ExtraExtraSmall
    | ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge
    | ExtraExtraLarge


type SpacingType
    = Margin
    | Padding


typeString : SpacingType -> String
typeString t =
    case t of
        Margin ->
            "m"

        Padding ->
            "p"


toString : Spacing -> String
toString pd =
    case pd of
        Zero ->
            "0"

        ExtraExtraSmall ->
            "xxs"

        ExtraSmall ->
            "xs"

        Small ->
            "s"

        Medium ->
            "m"

        Large ->
            "l"

        ExtraLarge ->
            "xl"

        ExtraExtraLarge ->
            "xxl"


spacing : SpacingType -> Maybe BP.Breakpoint -> Modifier -> Spacing -> Attribute msg
spacing t bp m sp =
    class <|
        case m of
            Bottom ->
                spacingClassName t "b" bp sp

            Top ->
                spacingClassName t "t" bp sp

            Left ->
                spacingClassName t "l" bp sp

            Right ->
                spacingClassName t "r" bp sp

            All ->
                spacingClassName t "" bp sp

            Vertical ->
                spacingClassName t "t" bp sp
                    ++ " "
                    ++ spacingClassName t "b" bp sp

            Horizontal ->
                spacingClassName t "l" bp sp
                    ++ " "
                    ++ spacingClassName t "r" bp sp


spacingClassName : SpacingType -> String -> Maybe BP.Breakpoint -> Spacing -> String
spacingClassName t m mbp sp =
    let
        bpstr =
            Maybe.map (\bp -> BP.toString bp ++ "-") mbp
                |> Maybe.withDefault ""
    in
    "u-"
        ++ bpstr
        ++ typeString t
        ++ m
        ++ "-"
        ++ toString sp


padding : Maybe BP.Breakpoint -> Modifier -> Spacing -> Attribute msg
padding =
    spacing Padding


margin : Maybe BP.Breakpoint -> Modifier -> Spacing -> Attribute msg
margin =
    spacing Margin
