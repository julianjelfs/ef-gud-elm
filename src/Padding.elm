module Padding exposing (Padding(..), paddingClass)

import Breakpoint as BP


type Padding
    = Zero
    | ExtraExtraSmall
    | ExtraSmall
    | Small
    | Medium
    | Large
    | ExtraLarge
    | ExtraExtraLarge


paddingClass : BP.Breakpoint -> Padding -> String
paddingClass bp pd =
    "u-" ++ BP.toString bp ++ "-p-" ++ toString pd


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
