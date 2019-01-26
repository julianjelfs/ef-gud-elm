module Components.Grid exposing
    ( GridColumnProps
    , GridRowProps
    , defaultColProps
    , defaultRowProps
    , gridColumn
    , gridRow
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias GridRowProps =
    {}


defaultRowProps : GridRowProps
defaultRowProps =
    {}


type alias BreakpointColumnProps =
    { span : Int
    }


type alias GridColumnProps =
    { small : Maybe BreakpointColumnProps
    , medium : Maybe BreakpointColumnProps
    , large : Maybe BreakpointColumnProps
    , extraLarge : Maybe BreakpointColumnProps
    }


bpPropsToClass : String -> BreakpointColumnProps -> String
bpPropsToClass prefix { span } =
    "-" ++ prefix ++ "-" ++ String.fromInt span


colPropsToClass : GridColumnProps -> String
colPropsToClass { small, medium, large, extraLarge } =
    [ Maybe.map (bpPropsToClass "s") small
    , Maybe.map (bpPropsToClass "m") medium
    , Maybe.map (bpPropsToClass "l") large
    , Maybe.map (bpPropsToClass "xl") extraLarge
    ]
        |> catMaybes
        |> List.intersperse " "
        |> List.foldr (++) ""


defaultColProps : GridColumnProps
defaultColProps =
    { small = Nothing
    , medium = Nothing
    , large = Nothing
    , extraLarge = Nothing
    }


gridRow : GridRowProps -> List (Html msg) -> Html msg
gridRow props cols =
    div
        [ class "ef-row" ]
        cols


gridColumn : GridColumnProps -> List (Html msg) -> Html msg
gridColumn props content =
    div
        [ class "ef-col"
        , class <| colPropsToClass props
        ]
        content
