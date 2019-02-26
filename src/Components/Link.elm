module Link exposing
    ( LinkProps
    , link
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias LinkProps msg =
    { href : String
    , onClick : Maybe msg
    }


link : LinkProps msg -> List (Html msg) -> Html msg
link props children =
    a
        ([ class "ef-link"
         , href props.href
         ]
            |> maybeAppend (Maybe.map onClick props.onClick)
        )
        children
