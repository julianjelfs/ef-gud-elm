module Spacing exposing
    ( Spacing(..)
    , SpacingType(..)
    , bottomMargin
    , bottomPad
    , horizontalMargin
    , horizontalPad
    , leftMargin
    , leftPad
    , margin
    , padding
    , rightMargin
    , rightPad
    , topMargin
    , topPad
    , verticalMargin
    , verticalPad
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)


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


spacingClassName : SpacingType -> String -> BP.Breakpoint -> Spacing -> String
spacingClassName type_ mod bp pd =
    "u-"
        ++ BP.toString bp
        ++ "-"
        ++ typeString type_
        ++ mod
        ++ "-"
        ++ toString pd


paddingClass : String -> BP.Breakpoint -> Spacing -> Attribute msg
paddingClass mod bp =
    class << spacingClassName Padding mod bp


marginClass : String -> BP.Breakpoint -> Spacing -> Attribute msg
marginClass mod bp =
    class << spacingClassName Margin mod bp


leftPad : Spacing -> Attribute msg
leftPad p =
    paddingClass "l" BP.Small p


leftMargin : Spacing -> Attribute msg
leftMargin p =
    marginClass "l" BP.Small p


rightPad : Spacing -> Attribute msg
rightPad p =
    paddingClass "r" BP.Small p


rightMargin : Spacing -> Attribute msg
rightMargin p =
    marginClass "r" BP.Small p


topPad : Spacing -> Attribute msg
topPad p =
    paddingClass "t" BP.Small p


topMargin : Spacing -> Attribute msg
topMargin p =
    marginClass "t" BP.Small p


bottomPad : Spacing -> Attribute msg
bottomPad p =
    paddingClass "t" BP.Small p


bottomMargin : Spacing -> Attribute msg
bottomMargin p =
    marginClass "b" BP.Small p


horizontalPad : Spacing -> Attribute msg
horizontalPad p =
    class <|
        ([ spacingClassName Padding "l" BP.Small p
         , spacingClassName Padding "r" BP.Small p
         ]
            |> String.join " "
        )


horizontalMargin : Spacing -> Attribute msg
horizontalMargin p =
    class <|
        ([ spacingClassName Margin "l" BP.Small p
         , spacingClassName Margin "r" BP.Small p
         ]
            |> String.join " "
        )


verticalPad : Spacing -> Attribute msg
verticalPad p =
    class <|
        ([ spacingClassName Padding "t" BP.Small p
         , spacingClassName Padding "b" BP.Small p
         ]
            |> String.join " "
        )


verticalMargin : Spacing -> Attribute msg
verticalMargin p =
    class <|
        ([ spacingClassName Margin "t" BP.Small p
         , spacingClassName Margin "b" BP.Small p
         ]
            |> String.join " "
        )


{-| same rules as css
one value, rule applies to all four sides
two values = vertical, horizontal
three values = top, left & right, bottom
four values = top, right, bottom, left
-}
padding : List Spacing -> Attribute msg
padding =
    spacingClasses Padding


margin : List Spacing -> Attribute msg
margin =
    spacingClasses Margin


spacingClasses : SpacingType -> List Spacing -> Attribute msg
spacingClasses type_ ps =
    class <|
        case ps of
            a :: [] ->
                spacingClassName type_ "" BP.Small a

            v :: h :: [] ->
                [ spacingClassName type_ "t" BP.Small v
                , spacingClassName type_ "b" BP.Small v
                , spacingClassName type_ "l" BP.Small h
                , spacingClassName type_ "r" BP.Small h
                ]
                    |> String.join " "

            t :: h :: b :: [] ->
                [ spacingClassName type_ "t" BP.Small t
                , spacingClassName type_ "b" BP.Small b
                , spacingClassName type_ "l" BP.Small h
                , spacingClassName type_ "r" BP.Small h
                ]
                    |> String.join " "

            t :: r :: b :: l :: [] ->
                [ spacingClassName type_ "t" BP.Small t
                , spacingClassName type_ "b" BP.Small b
                , spacingClassName type_ "l" BP.Small l
                , spacingClassName type_ "r" BP.Small r
                ]
                    |> String.join " "

            _ ->
                ""


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
