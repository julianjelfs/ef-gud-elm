module Utils exposing
    ( appendIf
    , catMaybes
    , concatIf
    , loremIpsum
    , maybeAppend
    , wrapClass
    )

import Html exposing (..)
import Html.Attributes exposing (..)


wrapClass : (Attribute msg -> p) -> String -> p
wrapClass p s =
    p <| class s


catMaybes : List (Maybe a) -> List a
catMaybes =
    List.filterMap identity


concatIf : Bool -> List a -> List a -> List a
concatIf pred toAppend appendTo =
    case pred of
        True ->
            appendTo ++ toAppend

        False ->
            appendTo


appendIf : Bool -> a -> List a -> List a
appendIf pred toAppend appendTo =
    if pred then
        appendTo ++ [ toAppend ]

    else
        appendTo


maybeAppend : Maybe a -> List a -> List a
maybeAppend m l =
    case m of
        Just x ->
            l ++ [ x ]

        Nothing ->
            l


loremIpsum : String
loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis convallis eros. Curabitur nulla mi, aliquet vel tempor a, pharetra ac massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis venenatis elit sed tempus rhoncus. Donec a quam dignissim, fermentum neque varius, porttitor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum lacinia venenatis nunc, a vehicula enim dictum eget. Etiam at elit turpis. In at pretium velit, quis blandit metus. Duis cursus orci eget tortor venenatis condimentum. Aenean semper sollicitudin eros sed vulputate. Morbi vehicula ut neque vitae faucibus. Duis non sollicitudin elit."
