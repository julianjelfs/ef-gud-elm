module Components.Grid exposing
    ( BreakpointColumnProps
    , GridColumnProps
    , GridRowProps
    , HorizontalAlignment(..)
    , VerticalAlignment(..)
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
    { horizontalAlignment : HorizontalAlignment
    , verticalAlignment : VerticalAlignment
    }


type HorizontalAlignment
    = HNone
    | HStart
    | HEnd
    | HCenter
    | HSpaceAround
    | HSpaceBetween


type VerticalAlignment
    = VNone
    | VStretch
    | VTop
    | VCenter
    | VBottom


hzToClass : HorizontalAlignment -> String
hzToClass ha =
    case ha of
        HNone ->
            ""

        HStart ->
            "-x-start"

        HEnd ->
            "-x-end"

        HCenter ->
            "-x-center"

        HSpaceAround ->
            "-x-around"

        HSpaceBetween ->
            "-x-between"


vtToClass : VerticalAlignment -> String
vtToClass va =
    case va of
        VNone ->
            ""

        VStretch ->
            "-y-stretch"

        VTop ->
            "-y-start"

        VCenter ->
            "-y-center"

        VBottom ->
            "-y-end"


defaultRowProps : GridRowProps
defaultRowProps =
    { horizontalAlignment = HNone, verticalAlignment = VNone }


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
    { span = 6, horizontalAlignment = HNone }



-- this might look a bit weird but it ensures that only grid columns can be
-- added to a grid row


type GridColumn msg
    = GridColumn (Html msg)


gridRow : GridRowProps -> List (GridColumn msg) -> Html msg
gridRow props cols =
    div
        [ class "ef-row"
        , class <| hzToClass props.horizontalAlignment
        , class <| vtToClass props.verticalAlignment
        ]
        (List.map (\(GridColumn c) -> c) cols)


gridColumn : GridColumnProps -> List (Html msg) -> GridColumn msg
gridColumn props content =
    GridColumn <|
        div
            [ class "ef-col"
            , class <| colPropsToClass props
            ]
            content
