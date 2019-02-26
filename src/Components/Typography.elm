module Typography exposing
    ( black
    , body
    , bodyBook
    , bold
    , book
    , h1
    , h2
    , h3
    , h4
    , h5
    , h6
    , italic
    , light
    , medium
    , para
    , paraBook
    , subtitle
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type TypoProp msg
    = TypoProp (Attribute msg)
    | Emphasis


classToProp : String -> TypoProp msg
classToProp =
    class >> TypoProp


italic : TypoProp msg
italic =
    Emphasis


light : TypoProp msg
light =
    classToProp "u-f-light"


book : TypoProp msg
book =
    classToProp "u-f-book"


medium : TypoProp msg
medium =
    classToProp "u-f-medium"


bold : TypoProp msg
bold =
    classToProp "u-f-bold"


black : TypoProp msg
black =
    classToProp "u-f-black"


h1 : List (TypoProp msg) -> List (Html msg) -> Html msg
h1 props =
    typo Html.h1 (classToProp "ef-h1" :: props)


h2 : List (TypoProp msg) -> List (Html msg) -> Html msg
h2 props =
    typo Html.h2 (classToProp "ef-h2" :: props)


h3 : List (TypoProp msg) -> List (Html msg) -> Html msg
h3 props =
    typo Html.h3 (classToProp "ef-h3" :: props)


h4 : List (TypoProp msg) -> List (Html msg) -> Html msg
h4 props =
    typo Html.h4 (classToProp "ef-h4" :: props)


h5 : List (TypoProp msg) -> List (Html msg) -> Html msg
h5 props =
    typo Html.h5 (classToProp "ef-h5" :: props)


h6 : List (TypoProp msg) -> List (Html msg) -> Html msg
h6 props =
    typo Html.h6 (classToProp "ef-h6" :: props)


subtitle : List (TypoProp msg) -> List (Html msg) -> Html msg
subtitle props =
    typo Html.p (classToProp "ef-text-subtitle" :: props)


body : List (TypoProp msg) -> List (Html msg) -> Html msg
body props =
    typo Html.p (classToProp "ef-text-body" :: props)


bodyBook : List (TypoProp msg) -> List (Html msg) -> Html msg
bodyBook props =
    typo Html.p (classToProp "ef-text-body -book" :: props)


para : List (TypoProp msg) -> List (Html msg) -> Html msg
para props =
    typo Html.p (classToProp "ef-text-para" :: props)


paraBook : List (TypoProp msg) -> List (Html msg) -> Html msg
paraBook props =
    typo Html.p (classToProp "ef-text-para -book" :: props)


partition : List (TypoProp msg) -> ( Bool, List (Attribute msg) )
partition =
    List.foldr
        (\p ( e, ps ) ->
            case p of
                Emphasis ->
                    ( True, ps )

                TypoProp a ->
                    ( e, a :: ps )
        )
        ( False, [] )


typo :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> List (TypoProp msg)
    -> List (Html msg)
    -> Html msg
typo ctor props content =
    let
        ( emphasis, attrs ) =
            partition props
    in
    if emphasis then
        em [] [ ctor attrs content ]

    else
        ctor attrs content
