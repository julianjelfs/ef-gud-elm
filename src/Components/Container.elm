module Components.Container exposing (container)

import Css exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href, src)
import Html.Events exposing (onClick)
import Theme exposing (theme)


container : List (Html msg) -> Html msg
container children =
    div
        []
        children
