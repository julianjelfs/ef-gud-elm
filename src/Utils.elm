module Utils exposing (appendIf, concatIf, maybeAppend)


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
