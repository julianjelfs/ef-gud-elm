module Components.Stack exposing
    ( StackProps
    , template
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias StackProps =
    {}


template : StackProps -> List (Html msg) -> Html msg
template props children =
    div
        [ class "ef-stack" ]
        children
