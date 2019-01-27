module Stories.Grid exposing (Model, Msg, init, update, view)

import Components.Container as Container
import Components.Grid as Grid
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


type alias BoxTags =
    { tag : Maybe String
    , stag : Maybe String
    , mtag : Maybe String
    , ltag : Maybe String
    , xltag : Maybe String
    , tall : Bool
    , content : Maybe String
    }


rowProps : Grid.GridRowProps
rowProps =
    Grid.defaultRowProps


colProps : Grid.GridColumnProps
colProps =
    Grid.defaultColProps


bpProps : Grid.BreakpointColumnProps
bpProps =
    Grid.defaultBreakpointProps


defaultTags : BoxTags
defaultTags =
    BoxTags Nothing Nothing Nothing Nothing Nothing False Nothing


box : BoxTags -> Html Msg
box { tag, stag, mtag, ltag, xltag, tall, content } =
    div
        ([ class "docs-box"
         , classList [ ( "tall", tall ) ]
         ]
            |> maybeAppend (Maybe.map (attribute "data-tag") tag)
            |> maybeAppend (Maybe.map (attribute "data-tag-s") stag)
            |> maybeAppend (Maybe.map (attribute "data-tag-m") mtag)
            |> maybeAppend (Maybe.map (attribute "data-tag-l") ltag)
            |> maybeAppend (Maybe.map (attribute "data-tag-xl") xltag)
        )
        [ text <| Maybe.withDefault "" content ]


autoWidths : Html Msg
autoWidths =
    div
        []
        [ h5 [] [ text "Auto widths" ]
        , p [] [ text "By default columns fill an equal amount of the available        space. If you add two, they will be 50% wide each. Simple" ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps
                [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            , Grid.gridColumn colProps [ taggedBox "ef-col" ]
            ]
        ]


taggedBoxFromProps : Grid.GridColumnProps -> Html Msg
taggedBoxFromProps { small, medium, large, extraLarge } =
    let
        spanToTag s =
            .span >> String.fromInt >> (++) ("-" ++ s ++ "-")
    in
    box
        { defaultTags
            | stag = Maybe.map (spanToTag "s") small
            , mtag = Maybe.map (spanToTag "m") medium
            , ltag = Maybe.map (spanToTag "l") large
            , xltag = Maybe.map (spanToTag "xl") extraLarge
        }


responsiveWidths : Html Msg
responsiveWidths =
    let
        props s m l xl =
            { colProps
                | small = Just { bpProps | span = s }
                , medium = Just { bpProps | span = m }
                , large = Just { bpProps | span = l }
                , extraLarge = Just { bpProps | span = xl }
            }

        col p =
            Grid.gridColumn p [ taggedBoxFromProps p ]
    in
    div
        []
        [ h5 [] [ text "Responsive widths" ]
        , p [] [ text "As the grid uses flexbox, you needn't set widths for all columns - you can set as many or as few as you like and the remaining columns will take up an equal amount of the remaining space." ]
        , p [] [ text "Column width is set per breakpoint. If you don't need the grid to adapt, you should use the .-s-{size} modifier class to set the width. 12 column spaces are available per row - columns exceeding this number will wrap onto the next line." ]
        , p [] [ text "Resize the container to see the class being used for each breakpoint. The classnames are based on the short versions of the breakpoint names: s, m, l, and xl." ]
        , Grid.gridRow rowProps
            (List.range 1 12
                |> List.map
                    (\_ -> col <| props 12 6 3 1)
            )
        , Grid.gridRow rowProps
            (List.range 1 12
                |> List.map
                    (\_ -> col <| props 12 6 1 2)
            )
        ]


borderedBox : Bool -> List (Html Msg) -> Html Msg
borderedBox tall content =
    div [ class "bordered-box", classList [ ( "tall", tall ) ] ] content


spannedProps : Int -> Grid.GridColumnProps
spannedProps n =
    Grid.setSpan n colProps


taggedBox : String -> Html Msg
taggedBox tag =
    box
        { defaultTags
            | tag = Just tag
        }


horizontalAlignment : Html Msg
horizontalAlignment =
    div
        []
        [ h5 [] [ text "Horizontal Alignment" ]
        , p [] [ text "You can align groups of columns on the X-axis" ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HStart }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-start" ] ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HEnd }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-end" ] ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HCenter }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-center" ] ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceAround }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-around" ]
                , Grid.gridColumn (spannedProps 4) [ taggedBox "-x-around" ]
                ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceBetween }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-between" ]
                , Grid.gridColumn (spannedProps 4) [ taggedBox "-x-between" ]
                ]
            ]
        ]


horizontalAlignmentChildOverrides : Html Msg
horizontalAlignmentChildOverrides =
    let
        startBp =
            Grid.setBreakpointHorizontalAlignment Grid.HStart bpProps
                |> Grid.setBreakpointSpan 2

        centerBp =
            Grid.setBreakpointHorizontalAlignment Grid.HCenter bpProps
                |> Grid.setBreakpointSpan 2

        endBp =
            Grid.setBreakpointHorizontalAlignment Grid.HEnd bpProps
                |> Grid.setBreakpointSpan 2

        props s =
            { colProps
                | small = Just s
            }
    in
    div
        []
        [ h5 [] [ text "Child Horizontal Alignment Overrides" ]
        , p [] [ text "These classes can be used on ef-col items for finer grained alignment control. Again these are settable per breakpoint, use the -s version to apply to all. Note that using these will use up the available space between flex items, effectively pushing siblings aside." ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceBetween }
                [ Grid.gridColumn (spannedProps 2) [ taggedBox "-x-between" ]
                , Grid.gridColumn (props startBp) [ taggedBox "-s-x-start" ]
                , Grid.gridColumn (spannedProps 2) [ box defaultTags ]
                ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HStart }
                [ Grid.gridColumn (spannedProps 2) [ taggedBox "-x-start" ]
                , Grid.gridColumn (spannedProps 2) [ box defaultTags ]
                , Grid.gridColumn (props centerBp) [ taggedBox "-s-x-center" ]
                ]
            ]
        , borderedBox False
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceBetween }
                [ Grid.gridColumn (spannedProps 2) [ taggedBox "-x-between" ]
                , Grid.gridColumn (props endBp) [ taggedBox "-s-x-end" ]
                , Grid.gridColumn (spannedProps 2) [ box defaultTags ]
                ]
            ]
        ]


verticalAlignment : Html Msg
verticalAlignment =
    div
        []
        [ h5 [] [ text "Vertical Alignment" ]
        , p [] [ text "You can align groups of columns on the Y-axis" ]
        , borderedBox True
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VStretch }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-stretch" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VTop }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-top" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VCenter }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-center" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VBottom }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-bottom" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
        ]


verticalAlignmentChildOverrides : Html Msg
verticalAlignmentChildOverrides =
    let
        topBp =
            Grid.setBreakpointVerticalAlignment Grid.VTop bpProps
                |> Grid.setBreakpointSpan 4

        centerBp =
            Grid.setBreakpointVerticalAlignment Grid.VCenter bpProps
                |> Grid.setBreakpointSpan 4

        bottomBp =
            Grid.setBreakpointVerticalAlignment Grid.VBottom bpProps
                |> Grid.setBreakpointSpan 4

        props s =
            { colProps
                | small = Just s
            }
    in
    div
        []
        [ h5 [] [ text "Child Vertical Alignment Overrides" ]
        , p [] [ text "These classes can be used on ef-col items for finer grained alignment control. Again these are settable per breakpoint, use the -s version to apply to all." ]
        , borderedBox True
            [ Grid.gridRow rowProps
                [ Grid.gridColumn (props topBp) [ taggedBox "-s-y-top" ]
                , Grid.gridColumn (props centerBp) [ taggedBox "-s-y-center" ]
                , Grid.gridColumn (props bottomBp) [ taggedBox "-s-y-bottom" ]
                ]
            ]
        ]


reordering : Html Msg
reordering =
    let
        firstBp s =
            { s | first = True, span = 3 }

        lastBp s =
            { s | last = True, span = 3 }
    in
    div
        []
        [ h5 [] [ text "Reordering" ]
        , p [] [ text "Use the ordering classes to change the visual order of the layout per breakpoint. Use .order- classes for controlling the visual order of your content. These classes are responsive, so you can set the order by breakpoint." ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "1" } ]
            , Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "2" } ]
            , Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "3" } ]
            , Grid.gridColumn
                (Grid.modifySmallBreakpointProps firstBp
                    colProps
                )
                [ box { defaultTags | content = Just "4", tag = Just "-{bp}-first" } ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn
                (Grid.modifySmallBreakpointProps lastBp
                    colProps
                )
                [ box { defaultTags | content = Just "1", tag = Just "-{bp}-last" } ]
            , Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "2" } ]
            , Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "3" } ]
            , Grid.gridColumn (spannedProps 3) [ box { defaultTags | content = Just "4" } ]
            ]
        ]


behaviour : Html Msg
behaviour =
    let
        shrinkBp s =
            { s | shrink = True, span = 6 }

        collapseBp s =
            { s | collapse = True, span = 6 }
    in
    div
        []
        [ h5 [] [ text "Column Behaviour" ]
        , p [] [ text "Use the sizing classes to change the behaviour of the layout per breakpoint." ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn
                (Grid.modifySmallBreakpointProps shrinkBp
                    colProps
                )
                [ box { defaultTags | content = Just "should shrink" } ]
            , Grid.gridColumn (spannedProps 6) [ box { defaultTags | tag = Just "-{bp}-shrink" } ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn
                (Grid.modifySmallBreakpointProps collapseBp
                    colProps
                )
                [ box { defaultTags | content = Just "should collapse" } ]
            , Grid.gridColumn
                (Grid.modifySmallBreakpointProps collapseBp
                    colProps
                )
                [ box { defaultTags | content = Just "should collapse" } ]
            ]
        ]


offsetting : Html Msg
offsetting =
    let
        offsetBp o sp s =
            { s | span = sp, offset = Just o }
    in
    div
        []
        [ h5 [] [ text "Offsetting Columns" ]
        , p [] [ text "Use the -{breakpoint}-offset modifiers to offset columns by the specified number." ]
        , div
            []
            (List.range 1 11
                |> List.map
                    (\n ->
                        Grid.gridRow rowProps
                            [ Grid.gridColumn
                                (Grid.modifySmallBreakpointProps
                                    (offsetBp
                                        (12
                                            - n
                                        )
                                        n
                                    )
                                    colProps
                                )
                                [ taggedBox <| "-s-offset-" ++ String.fromInt (12 - n) ]
                            ]
                    )
            )
        ]


view : Model -> Html Msg
view model =
    Container.container
        [ h3 [] [ text "This is the grid component" ]
        , autoWidths
        , br [] []
        , responsiveWidths
        , br [] []
        , horizontalAlignment
        , br [] []
        , horizontalAlignmentChildOverrides
        , br [] []
        , verticalAlignment
        , br [] []
        , verticalAlignmentChildOverrides
        , br [] []
        , reordering
        , br [] []
        , behaviour
        , br [] []
        , offsetting
        ]
