module Components.Grid exposing
    ( BreakpointColumnProps
    , GridColumnProps
    , GridRowProps
    , HorizontalAlignment(..)
    , defaultBreakpointProps
    , defaultColProps
    , defaultRowProps
    , gridColumn
    , gridRow
    , setBreakpointHorizontalAlignment
    , setBreakpointSpan
    , setSpan
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias GridRowProps =
    { horizontalAlignment : HorizontalAlignment }


type HorizontalAlignment
    = None
    | Start
    | End
    | Center
    | SpaceAround
    | SpaceBetween


hzToClass : HorizontalAlignment -> String
hzToClass ha =
    case ha of
        None ->
            ""

        Start ->
            "-x-start"

        End ->
            "-x-end"

        Center ->
            "-x-center"

        SpaceAround ->
            "-x-around"

        SpaceBetween ->
            "-x-between"


defaultRowProps : GridRowProps
defaultRowProps =
    { horizontalAlignment = None }


type alias BreakpointColumnProps =
    { span : Int
    , horizontalAlignment : HorizontalAlignment
    }


type alias GridColumnProps =
    { small : Maybe BreakpointColumnProps
    , medium : Maybe BreakpointColumnProps
    , large : Maybe BreakpointColumnProps
    , extraLarge : Maybe BreakpointColumnProps
    }


bpPropsToSpanClass : String -> BreakpointColumnProps -> String
bpPropsToSpanClass prefix { span } =
    "-" ++ prefix ++ "-" ++ String.fromInt span


bpPropsToHzClass : String -> BreakpointColumnProps -> String
bpPropsToHzClass prefix { horizontalAlignment } =
    "-" ++ prefix ++ hzToClass horizontalAlignment


colPropsToClass : GridColumnProps -> String
colPropsToClass { small, medium, large, extraLarge } =
    [ Maybe.map (bpPropsToSpanClass "s") small
    , Maybe.map (bpPropsToSpanClass "m") medium
    , Maybe.map (bpPropsToSpanClass "l") large
    , Maybe.map (bpPropsToSpanClass "xl") extraLarge
    , Maybe.map (bpPropsToHzClass "s") small
    , Maybe.map (bpPropsToHzClass "m") medium
    , Maybe.map (bpPropsToHzClass "l") large
    , Maybe.map (bpPropsToHzClass "xl") extraLarge
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


setBreakpointSpan : Int -> BreakpointColumnProps -> BreakpointColumnProps
setBreakpointSpan n bp =
    { bp | span = n }


setSpan : Int -> GridColumnProps -> GridColumnProps
setSpan n p =
    case p.small of
        Nothing ->
            { p | small = Just { defaultBreakpointProps | span = n } }

        Just s ->
            { p | small = Just { s | span = n } }


setBreakpointHorizontalAlignment : HorizontalAlignment -> BreakpointColumnProps -> BreakpointColumnProps
setBreakpointHorizontalAlignment ha bp =
    { bp | horizontalAlignment = ha }


defaultBreakpointProps : BreakpointColumnProps
defaultBreakpointProps =
    { span = 6, horizontalAlignment = None }


gridRow : GridRowProps -> List (Html msg) -> Html msg
gridRow props cols =
    div
        [ class "ef-row"
        , class <| hzToClass props.horizontalAlignment
        ]
        cols


gridColumn : GridColumnProps -> List (Html msg) -> Html msg
gridColumn props content =
    div
        [ class "ef-col"
        , class <| colPropsToClass props
        ]
        content
