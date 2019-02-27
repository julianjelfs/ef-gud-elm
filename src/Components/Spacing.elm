module Spacing exposing
    ( Modifier(..)
    , Spacing(..)
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
    , spacing
    , topMargin
    , topPad
    , verticalMargin
    , verticalPad
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


modifierString : Modifier -> String
modifierString m =
    case m of
        Bottom ->
            "b"

        Top ->
            "t"

        Left ->
            "l"

        Right ->
            "r"

        All ->
            ""


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


spacing : Maybe BP.Breakpoint -> SpacingType -> Modifier -> Spacing -> Attribute msg
spacing mbp type_ modifier sp =
    class <|
        spacingClassName
            type_
            modifier
            (Maybe.withDefault BP.Small mbp)
            sp


spacingClassName : SpacingType -> Modifier -> BP.Breakpoint -> Spacing -> String
spacingClassName type_ mod bp pd =
    "u-"
        ++ BP.toString bp
        ++ "-"
        ++ typeString type_
        ++ modifierString mod
        ++ "-"
        ++ toString pd


paddingClass : Modifier -> BP.Breakpoint -> Spacing -> Attribute msg
paddingClass mod bp =
    class << spacingClassName Padding mod bp


marginClass : Modifier -> BP.Breakpoint -> Spacing -> Attribute msg
marginClass mod bp =
    class << spacingClassName Margin mod bp


leftPad : Spacing -> Attribute msg
leftPad p =
    paddingClass Left BP.Small p


leftMargin : Spacing -> Attribute msg
leftMargin p =
    marginClass Left BP.Small p


rightPad : Spacing -> Attribute msg
rightPad p =
    paddingClass Right BP.Small p


rightMargin : Spacing -> Attribute msg
rightMargin p =
    marginClass Right BP.Small p


topPad : Spacing -> Attribute msg
topPad p =
    paddingClass Top BP.Small p


topMargin : Spacing -> Attribute msg
topMargin p =
    marginClass Top BP.Small p


bottomPad : Spacing -> Attribute msg
bottomPad p =
    paddingClass Top BP.Small p


bottomMargin : Spacing -> Attribute msg
bottomMargin p =
    marginClass Bottom BP.Small p


horizontalPad : Spacing -> Attribute msg
horizontalPad p =
    class <|
        ([ spacingClassName Padding Left BP.Small p
         , spacingClassName Padding Right BP.Small p
         ]
            |> String.join " "
        )


horizontalMargin : Spacing -> Attribute msg
horizontalMargin p =
    class <|
        ([ spacingClassName Margin Left BP.Small p
         , spacingClassName Margin Right BP.Small p
         ]
            |> String.join " "
        )


verticalPad : Spacing -> Attribute msg
verticalPad p =
    class <|
        ([ spacingClassName Padding Top BP.Small p
         , spacingClassName Padding Bottom BP.Small p
         ]
            |> String.join " "
        )


verticalMargin : Spacing -> Attribute msg
verticalMargin p =
    class <|
        ([ spacingClassName Margin Top BP.Small p
         , spacingClassName Margin Bottom BP.Small p
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
                spacingClassName type_ All BP.Small a

            v :: h :: [] ->
                [ spacingClassName type_ Top BP.Small v
                , spacingClassName type_ Bottom BP.Small v
                , spacingClassName type_ Left BP.Small h
                , spacingClassName type_ Right BP.Small h
                ]
                    |> String.join " "

            t :: h :: b :: [] ->
                [ spacingClassName type_ Top BP.Small t
                , spacingClassName type_ Bottom BP.Small b
                , spacingClassName type_ Left BP.Small h
                , spacingClassName type_ Right BP.Small h
                ]
                    |> String.join " "

            t :: r :: b :: l :: [] ->
                [ spacingClassName type_ Top BP.Small t
                , spacingClassName type_ Bottom BP.Small b
                , spacingClassName type_ Left BP.Small l
                , spacingClassName type_ Right BP.Small r
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
