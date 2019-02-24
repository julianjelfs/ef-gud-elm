module Components.Table exposing (table)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type TableProp msg
    = TableProp (Attribute msg)


table : List (TableProp msg) -> Html msg
table props =
    div
        ([ class "ef-table" ] ++ List.map (\(TableProp a) -> a) props)
        [ text "table stuff" ]
