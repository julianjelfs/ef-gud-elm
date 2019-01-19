module Components.Surface exposing (surface)

import Color exposing (ThemeColor, backgroundClass)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias SurfaceProps =
    {}


surface : SurfaceProps -> List (Html msg) -> Html msg
surface props children =
    div
        [ class "ef-surface"
        ]
        children
