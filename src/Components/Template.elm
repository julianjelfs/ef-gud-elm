module Components.Template exposing
    ( TemplateProps
    , template
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias TemplateProps =
    {}


template : TemplateProps -> List (Html msg) -> Html msg
template props children =
    div
        [ class "ef-template" ]
        children
