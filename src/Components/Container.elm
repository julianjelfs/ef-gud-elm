module Components.Container exposing (container)

import Html exposing (..)
import Html.Attributes exposing (..)


container : List (Html msg) -> Html msg
container children =
    div
        [ class "ef-container" ]
        children
