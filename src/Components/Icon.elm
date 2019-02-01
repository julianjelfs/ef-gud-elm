module Components.Icon exposing
    ( Icon(..)
    , IconProp
    , icon
    , iconType
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type Icon
    = ChevronLeft
    | ChevronRight
    | ChevronUp
    | ChevronDown
    | ChevronDoubleLeft
    | ChevronDoubleRight


toString : Icon -> String
toString i =
    case i of
        ChevronLeft ->
            "-chevron-left"

        ChevronRight ->
            "-chevron-right"

        ChevronUp ->
            "-chevron-up"

        ChevronDown ->
            "-chevron-down"

        ChevronDoubleLeft ->
            "-chevron-double-left"

        ChevronDoubleRight ->
            "-chevron-double-right"


iconType : Icon -> IconProp msg
iconType =
    IconProp << class << toString


type IconProp msg
    = IconProp (Attribute msg)


icon : List (IconProp msg) -> Html msg
icon props =
    span
        ([ class "ef-icon" ] ++ List.map (\(IconProp a) -> a) props)
        []
