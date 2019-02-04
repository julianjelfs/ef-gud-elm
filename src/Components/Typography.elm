module Components.Typography exposing
    ( body
    , bodyBook
    , h1
    , h2
    , h3
    , h4
    , h5
    , h6
    , para
    , paraBook
    , subtitle
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


h1 : List (Html msg) -> Html msg
h1 =
    typo Html.h1 "ef-h1"


h2 : List (Html msg) -> Html msg
h2 =
    typo Html.h2 "ef-h2"


h3 : List (Html msg) -> Html msg
h3 =
    typo Html.h3 "ef-h3"


h4 : List (Html msg) -> Html msg
h4 =
    typo Html.h4 "ef-h4"


h5 : List (Html msg) -> Html msg
h5 =
    typo Html.h5 "ef-h5"


h6 : List (Html msg) -> Html msg
h6 =
    typo Html.h6 "ef-h6"


subtitle : List (Html msg) -> Html msg
subtitle =
    typo Html.p "ef-text-subtitle"


body : List (Html msg) -> Html msg
body =
    typo Html.p "ef-text-body"


bodyBook : List (Html msg) -> Html msg
bodyBook =
    typo Html.p "ef-text-body -book"


para : List (Html msg) -> Html msg
para =
    typo Html.p "ef-text-para"


paraBook : List (Html msg) -> Html msg
paraBook =
    typo Html.p "ef-text-para -book"


typo :
    (List (Attribute msg) -> List (Html msg) -> Html msg)
    -> String
    -> List (Html msg)
    -> Html msg
typo ctor cls content =
    ctor [ class cls ] content
