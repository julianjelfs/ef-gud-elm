module Components.Breadcrumb exposing (breadcrumb)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type BreadcrumbProp msg
    = BreadcrumbProp (Attribute msg)


breadcrumb : List (BreadcrumbProp msg) -> Html msg
breadcrumb props =
    div
        ([ class "ef-breadcrumb" ] ++ List.map (\(BreadcrumbProp a) -> a) props)
        [ text "breadcrumb stuff" ]
