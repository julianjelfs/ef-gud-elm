module Stories.Utils exposing (BoxTags, borderedBox, box, defaultTags, taggedBox)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias BoxTags =
    { tag : Maybe String
    , stag : Maybe String
    , mtag : Maybe String
    , ltag : Maybe String
    , xltag : Maybe String
    , tall : Bool
    , content : Maybe String
    , bgClass : Maybe String
    }


defaultTags : BoxTags
defaultTags =
    BoxTags Nothing Nothing Nothing Nothing Nothing False Nothing Nothing


box : BoxTags -> Html msg
box { tag, stag, mtag, ltag, xltag, tall, content, bgClass } =
    div
        ([ class "docs-box"
         , classList [ ( "tall", tall ) ]
         ]
            |> maybeAppend (Maybe.map class bgClass)
            |> maybeAppend (Maybe.map (attribute "data-tag") tag)
            |> maybeAppend (Maybe.map (attribute "data-tag-s") stag)
            |> maybeAppend (Maybe.map (attribute "data-tag-m") mtag)
            |> maybeAppend (Maybe.map (attribute "data-tag-l") ltag)
            |> maybeAppend (Maybe.map (attribute "data-tag-xl") xltag)
        )
        [ text <| Maybe.withDefault "" content ]


borderedBox : Bool -> List (Html msg) -> Html msg
borderedBox tall content =
    div [ class "bordered-box", classList [ ( "tall", tall ) ] ] content


taggedBox : String -> Html msg
taggedBox tag =
    box
        { defaultTags
            | tag = Just tag
        }
