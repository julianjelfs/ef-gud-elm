module Components.Template exposing (template)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type TemplateProp msg
    = TemplateProp (Attribute msg)


template : List (TemplateProp msg) -> Html msg
template props =
    div
        ([ class "ef-template" ] ++ List.map (\(TemplateProp a) -> a) props)
        [ text "template stuff" ]
