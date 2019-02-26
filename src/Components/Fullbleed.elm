module Fullbleed exposing
    ( fullHeight
    , fullbleed
    , gradient
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type FullbleedProp msg
    = FullbleedProp (Attribute msg)


classToProp : String -> FullbleedProp msg
classToProp =
    class >> FullbleedProp


gradient : FullbleedProp msg
gradient =
    classToProp "-with-gradient"


fullHeight : FullbleedProp msg
fullHeight =
    classToProp "-full-height"


fullbleed : String -> List (FullbleedProp msg) -> List (Html msg) -> Html msg
fullbleed url props content =
    div (class "ef-fullbleed" :: List.map (\(FullbleedProp a) -> a) props)
        [ div
            [ class "ef-fullbleed__bg"
            , style "background-image" ("url('" ++ url ++ "')")
            ]
            []
        , div
            [ class "ef-fullbleed__content" ]
            content
        ]
