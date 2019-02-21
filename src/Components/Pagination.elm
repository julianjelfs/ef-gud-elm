module Components.Pagination exposing
    ( Size(..)
    , size
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type PaginationProp msg
    = PaginationProp (Attribute msg)


type Size
    = Small
    | Large


classToProp : String -> PaginationProp msg
classToProp =
    class >> PaginationProp


size : Size -> PaginationProp msg
size s =
    case s of
        Small ->
            classToProp "ef-pagination--sm"

        Large ->
            classToProp "ef-pagination--lg"


pager : List (PaginationProp msg) -> Html msg
pager props =
    div (class "ef-pagination" :: List.map (\(PaginationProp a) -> a) props)
        [ text "TODO" ]
