module Padding exposing
    ( Padding(..)
    , bottomPad
    , horizontalPad
    , leftPad
    , paddingClass
    , paddingClasses
    , rightPad
    , topPad
    , verticalPad
    )

import Breakpoint as BP
import Html exposing (..)


type Padding
    = Zero
    | ExtraExtraSmall
    | ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge
    | ExtraExtraLarge


paddingClass : BP.Breakpoint -> Padding -> String -> String
paddingClass bp pd mod =
    "u-" ++ BP.toString bp ++ "-p" ++ mod ++ "-" ++ toString pd


leftPad : Padding -> (String -> p) -> p
leftPad p tag =
    tag <| paddingClass BP.Small p "l"


rightPad : Padding -> (String -> p) -> p
rightPad p tag =
    tag <| paddingClass BP.Small p "r"


topPad : Padding -> (String -> p) -> p
topPad p tag =
    tag <| paddingClass BP.Small p "t"


bottomPad : Padding -> (String -> p) -> p
bottomPad p tag =
    tag <| paddingClass BP.Small p "b"


horizontalPad : Padding -> (String -> p) -> p
horizontalPad p tag =
    tag <|
        ([ paddingClass BP.Small p "l"
         , paddingClass BP.Small p "r"
         ]
            |> String.join " "
        )


verticalPad : Padding -> (String -> p) -> p
verticalPad p tag =
    tag <|
        ([ paddingClass BP.Small p "t"
         , paddingClass BP.Small p "b"
         ]
            |> String.join " "
        )



-- same rules as css
-- one value, rule applies to all four sides
-- two values = vertical, horizontal
-- three values = top, left & right, bottom
-- four values = top, right, bottom, left


paddingClasses : List Padding -> (String -> p) -> p
paddingClasses ps tag =
    case ps of
        a :: [] ->
            tag <| paddingClass BP.Small a ""

        v :: h :: [] ->
            tag <|
                ([ paddingClass BP.Small v "t"
                 , paddingClass BP.Small v "b"
                 , paddingClass BP.Small h "l"
                 , paddingClass BP.Small h "r"
                 ]
                    |> String.join " "
                )

        t :: h :: b :: [] ->
            tag <|
                ([ paddingClass BP.Small t "t"
                 , paddingClass BP.Small b "b"
                 , paddingClass BP.Small h "l"
                 , paddingClass BP.Small h "r"
                 ]
                    |> String.join " "
                )

        t :: r :: b :: l :: [] ->
            tag <|
                ([ paddingClass BP.Small t "t"
                 , paddingClass BP.Small b "b"
                 , paddingClass BP.Small l "l"
                 , paddingClass BP.Small r "r"
                 ]
                    |> String.join " "
                )

        _ ->
            tag ""


toString : Padding -> String
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
