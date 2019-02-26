module Breakpoint exposing (Breakpoint(..), sizeClass, toString)


type Breakpoint
    = Small
    | Medium
    | Large
    | ExtraLarge


toString : Breakpoint -> String
toString bp =
    case bp of
        Small ->
            "s"

        Medium ->
            "m"

        Large ->
            "l"

        ExtraLarge ->
            "xl"


sizeClass : Breakpoint -> String
sizeClass bp =
    "-" ++ toString bp
