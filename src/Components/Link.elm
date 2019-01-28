module Components.Link exposing
    ( LinkProps
    , linkComponent
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias LinkProps =
    {}


linkComponent : LinkProps -> List (Html msg) -> Html msg
linkComponent props children =
    div
        [ class "ef-link" ]
        children
