module Utils exposing (concatIf, maybeAppend)

import Css exposing (..)


concatIf : Bool -> List Style -> List Style -> List Style
concatIf pred toAppend appendTo =
    case pred of
        True ->
            appendTo ++ toAppend

        False ->
            appendTo


maybeAppend : Maybe a -> List a -> List a
maybeAppend m l =
    case m of
        Just x ->
            l ++ [ x ]

        Nothing ->
            l
