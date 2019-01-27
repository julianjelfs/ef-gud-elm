module Components.Grid exposing
    ( BreakpointColumnProps
    , GridColumnProps
    , GridRowProps
    , HorizontalAlignment(..)
    , VerticalAlignment(..)
    , colPropsToClass
    , defaultBreakpointProps
    , defaultColProps
    , defaultRowProps
    , gridColumn
    , gridRow
    , modifySmallBreakpointProps
    , setBreakpointHorizontalAlignment
    , setBreakpointSpan
    , setBreakpointVerticalAlignment
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


hzToClass : HorizontalAlignment -> Maybe String
hzToClass ha =
    case ha of
        HNone ->
            Nothing

        HStart ->
            Just "-x-start"

        HEnd ->
            Just "-x-end"

        HCenter ->
            Just "-x-center"

        HSpaceAround ->
            Just "-x-around"

        HSpaceBetween ->
            Just "-x-between"


vtToClass : VerticalAlignment -> Maybe String
vtToClass va =
    case va of
        VNone ->
            Nothing

        VStretch ->
            Just "-y-stretch"

        VTop ->
            Just "-y-start"

        VCenter ->
            Just "-y-center"

        VBottom ->
            Just "-y-end"


defaultRowProps : GridRowProps
defaultRowProps =
    { horizontalAlignment = HNone, verticalAlignment = VNone }


type alias BreakpointColumnProps =
    { span : Int
    , horizontalAlignment : HorizontalAlignment
    , verticalAlignment : VerticalAlignment
    , first : Bool
    , last : Bool
    , shrink : Bool
    , collapse : Bool
    , offset : Maybe Int
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


bpPropsToHzClass : String -> BreakpointColumnProps -> Maybe String
bpPropsToHzClass prefix =
    .horizontalAlignment >> hzToClass >> Maybe.map (\c -> "-" ++ prefix ++ c)


bpPropsToVtClass : String -> BreakpointColumnProps -> Maybe String
bpPropsToVtClass prefix =
    .verticalAlignment >> vtToClass >> Maybe.map (\c -> "-" ++ prefix ++ c)


bpPropsToOffsetClass : String -> BreakpointColumnProps -> Maybe String
bpPropsToOffsetClass prefix =
    .offset >> Maybe.map String.fromInt >> Maybe.map (\o -> "-" ++ prefix ++ "-offset-" ++ o)


bpPropsToBoolClass : String -> String -> Bool -> Maybe String
bpPropsToBoolClass prefix label prop =
    if prop then
        Just <| "-" ++ prefix ++ "-" ++ label

    else
        Nothing


colPropsToClass : GridColumnProps -> String
colPropsToClass { small, medium, large, extraLarge } =
    [ ( "s", small ), ( "m", medium ), ( "l", large ), ( "xl", extraLarge ) ]
        |> List.concatMap
            (\( k, v ) ->
                [ Maybe.map (bpPropsToSpanClass k) v
                , Maybe.andThen (bpPropsToOffsetClass k) v
                , Maybe.andThen (bpPropsToHzClass k) v
                , Maybe.andThen (bpPropsToVtClass k) v
                , Maybe.andThen (.first >> bpPropsToBoolClass k "first") v
                , Maybe.andThen (.last >> bpPropsToBoolClass k "last") v
                , Maybe.andThen (.shrink >> bpPropsToBoolClass k "shrink") v
                , Maybe.andThen (.collapse >> bpPropsToBoolClass k "collapse") v
                ]
            )
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
    modifySmallBreakpointProps (\s -> { s | span = n }) p


modifySmallBreakpointProps : (BreakpointColumnProps -> BreakpointColumnProps) -> GridColumnProps -> GridColumnProps
modifySmallBreakpointProps fn p =
    case p.small of
        Nothing ->
            { p | small = Just (fn defaultBreakpointProps) }

        Just s ->
            { p | small = Just (fn s) }


setBreakpointHorizontalAlignment :
    HorizontalAlignment
    -> BreakpointColumnProps
    -> BreakpointColumnProps
setBreakpointHorizontalAlignment ha bp =
    { bp | horizontalAlignment = ha }


setBreakpointVerticalAlignment :
    VerticalAlignment
    -> BreakpointColumnProps
    -> BreakpointColumnProps
setBreakpointVerticalAlignment va bp =
    { bp | verticalAlignment = va }


defaultBreakpointProps : BreakpointColumnProps
defaultBreakpointProps =
    { span = 6
    , horizontalAlignment = HNone
    , verticalAlignment = VNone
    , first = False
    , last = False
    , shrink = False
    , collapse = False
    , offset = Nothing
    }



-- this might look a bit weird but it ensures that only grid columns can be
-- added to a grid row


type GridColumn msg
    = GridColumn (Html msg)


gridRow : GridRowProps -> List (GridColumn msg) -> Html msg
gridRow props cols =
    div
        [ class "ef-row"
        , class <| Maybe.withDefault "" (hzToClass props.horizontalAlignment)
        , class <| Maybe.withDefault "" (vtToClass props.verticalAlignment)
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
