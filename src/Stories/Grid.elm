module Stories.Grid exposing (Model, Msg, init, update, view)

import Components.Container as Container
import Components.Grid as Grid
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Stories.Utils exposing (..)
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


autoWidths : Html Msg
autoWidths =
    div
        []
        [ h5 [] [ text "Auto widths" ]
        , p [] [ text "By default columns fill an equal amount of the available        space. If you add two, they will be 50% wide each. Simple" ]
        , Grid.row []
            [ Grid.col []
                [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            ]
        , Grid.row []
            [ Grid.col [] [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            ]
        , Grid.row []
            [ Grid.col [] [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            , Grid.col [] [ taggedBox "ef-col" ]
            ]
        ]


taggedBoxFromSpans : Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int -> Html Msg
taggedBoxFromSpans small medium large extraLarge =
    let
        spanToTag s =
            String.fromInt >> (++) ("-" ++ s ++ "-")
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
    div
        []
        [ h5 [] [ text "Responsive widths" ]
        , p [] [ text "As the grid uses flexbox, you needn't set widths for all columns - you can set as many or as few as you like and the remaining columns will take up an equal amount of the remaining space." ]
        , p [] [ text "Column width is set per breakpoint. If you don't need the grid to adapt, you should use the .-s-{size} modifier class to set the width. 12 column spaces are available per row - columns exceeding this number will wrap onto the next line." ]
        , p [] [ text "Resize the container to see the class being used for each breakpoint. The classnames are based on the short versions of the breakpoint names: s, m, l, and xl." ]
        , Grid.row []
            (List.range 1 12
                |> List.map
                    (\_ ->
                        Grid.col
                            [ Grid.smallSpan 12
                            , Grid.mediumSpan 6
                            , Grid.largeSpan 3
                            , Grid.extraLargeSpan 1
                            ]
                            [ taggedBoxFromSpans (Just 12) (Just 6) (Just 3) (Just 1) ]
                    )
            )
        , Grid.row []
            (List.range 1 12
                |> List.map
                    (\_ ->
                        Grid.col
                            [ Grid.smallSpan 12
                            , Grid.mediumSpan 6
                            , Grid.largeSpan 1
                            , Grid.extraLargeSpan 2
                            ]
                            [ taggedBoxFromSpans (Just 12) (Just 6) (Just 1) (Just 2) ]
                    )
            )
        ]


horizontalAlignment : Html Msg
horizontalAlignment =
    div
        []
        [ h5 [] [ text "Horizontal Alignment" ]
        , p [] [ text "You can align groups of columns on the X-axis" ]
        , borderedBox False
            [ Grid.row [ Grid.xstart ]
                [ Grid.col [ Grid.defaultSpan 6 ] [ taggedBox "-x-start" ] ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xend ]
                [ Grid.col [ Grid.defaultSpan 6 ] [ taggedBox "-x-end" ] ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xcenter ]
                [ Grid.col [ Grid.defaultSpan 6 ] [ taggedBox "-x-center" ] ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xaround ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-around" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-around" ]
                ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xbetween ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-between" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-between" ]
                ]
            ]
        ]


horizontalAlignmentChildOverrides : Html Msg
horizontalAlignmentChildOverrides =
    div
        []
        [ h5 [] [ text "Child Horizontal Alignment Overrides" ]
        , p [] [ text "These classes can be used on ef-col items for finer grained alignment control. Again these are settable per breakpoint, use the -s version to apply to all. Note that using these will use up the available space between flex items, effectively pushing siblings aside." ]
        , borderedBox False
            [ Grid.row [ Grid.xbetween ]
                [ Grid.col [ Grid.defaultSpan 2 ] [ taggedBox "-x-between" ]
                , Grid.col [ Grid.smallSpan 2, Grid.smallxstart ] [ taggedBox "-s-x-start" ]
                , Grid.col [ Grid.smallSpan 2 ] [ box defaultTags ]
                ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xstart ]
                [ Grid.col [ Grid.defaultSpan 2 ] [ taggedBox "-x-start" ]
                , Grid.col [ Grid.defaultSpan 2 ] [ box defaultTags ]
                , Grid.col [ Grid.defaultSpan 2, Grid.smallxcenter ] [ taggedBox "-s-x-center" ]
                ]
            ]
        , borderedBox False
            [ Grid.row [ Grid.xbetween ]
                [ Grid.col [ Grid.defaultSpan 2 ] [ taggedBox "-x-between" ]
                , Grid.col [ Grid.defaultSpan 2, Grid.smallxend ] [ taggedBox "-s-x-end" ]
                , Grid.col [ Grid.defaultSpan 2 ] [ box defaultTags ]
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
            [ Grid.row [ Grid.ystretch ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-y-stretch" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.row [ Grid.ytop ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-y-top" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.row [ Grid.ycenter ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-center" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Grid.row [ Grid.ybottom ]
                [ Grid.col [ Grid.defaultSpan 4 ] [ taggedBox "-x-bottom" ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                , Grid.col [ Grid.defaultSpan 4 ] [ box defaultTags ]
                ]
            ]
        ]


verticalAlignmentChildOverrides : Html Msg
verticalAlignmentChildOverrides =
    div
        []
        [ h5 [] [ text "Child Vertical Alignment Overrides" ]
        , p [] [ text "These classes can be used on ef-col items for finer grained alignment control. Again these are settable per breakpoint, use the -s version to apply to all." ]
        , borderedBox True
            [ Grid.row []
                [ Grid.col [ Grid.smallSpan 4, Grid.smallytop ] [ taggedBox "-s-y-top" ]
                , Grid.col [ Grid.smallSpan 4, Grid.smallycenter ] [ taggedBox "-s-y-center" ]
                , Grid.col [ Grid.smallSpan 4, Grid.smallybottom ] [ taggedBox "-s-y-bottom" ]
                ]
            ]
        ]


reordering : Html Msg
reordering =
    div
        []
        [ h5 [] [ text "Reordering" ]
        , p [] [ text "Use the ordering classes to change the visual order of the layout per breakpoint. Use .order- classes for controlling the visual order of your content. These classes are responsive, so you can set the order by breakpoint." ]
        , Grid.row []
            [ Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "1" } ]
            , Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "2" } ]
            , Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "3" } ]
            , Grid.col [ Grid.defaultSpan 3, Grid.smallFirst ] [ box { defaultTags | content = Just "4", tag = Just "-{bp}-first" } ]
            ]
        , Grid.row []
            [ Grid.col [ Grid.defaultSpan 3, Grid.smallLast ] [ box { defaultTags | content = Just "1", tag = Just "-{bp}-last" } ]
            , Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "2" } ]
            , Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "3" } ]
            , Grid.col [ Grid.defaultSpan 3 ] [ box { defaultTags | content = Just "4" } ]
            ]
        ]


behaviour : Html Msg
behaviour =
    div
        []
        [ h5 [] [ text "Column Behaviour" ]
        , p [] [ text "Use the sizing classes to change the behaviour of the layout per breakpoint." ]
        , Grid.row []
            [ Grid.col [ Grid.defaultSpan 6, Grid.smallShrink ]
                [ box { defaultTags | content = Just "should shrink" } ]
            , Grid.col [ Grid.defaultSpan 6 ] [ box { defaultTags | tag = Just "-{bp}-shrink" } ]
            ]
        , Grid.row []
            [ Grid.col [ Grid.defaultSpan 6, Grid.smallCollapse ]
                [ box { defaultTags | content = Just "should collapse" } ]
            , Grid.col
                [ Grid.defaultSpan 6, Grid.smallCollapse ]
                [ box { defaultTags | content = Just "should collapse" } ]
            ]
        ]


offsetting : Html Msg
offsetting =
    div
        []
        [ h5 [] [ text "Offsetting Columns" ]
        , p [] [ text "Use the -{breakpoint}-offset modifiers to offset columns by the specified number." ]
        , div
            []
            (List.range 1 11
                |> List.map
                    (\n ->
                        Grid.row []
                            [ Grid.col
                                [ Grid.smallSpan n
                                , Grid.smallOffset
                                    (12
                                        - n
                                    )
                                ]
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
