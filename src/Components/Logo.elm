module Components.Logo exposing
    ( inverse
    , logo
    , simple
    , small
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type LogoProp msg
    = LogoProp (Attribute msg)


classToProp : String -> LogoProp msg
classToProp =
    class >> LogoProp


simple : LogoProp msg
simple =
    classToProp "ef-logo--simple"


small : LogoProp msg
small =
    classToProp "ef-logo--small"


inverse : LogoProp msg
inverse =
    classToProp "-white"


logo : List (LogoProp msg) -> Html msg
logo props =
    span (class "ef-logo" :: List.map (\(LogoProp a) -> a) props) []
