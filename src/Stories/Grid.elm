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
    }


rowProps : Grid.GridRowProps
rowProps =
    Grid.defaultRowProps


colProps : Grid.GridColumnProps
colProps =
    Grid.defaultColProps


bp : Grid.BreakpointColumnProps
bp =
    Grid.defaultBreakpointProps


defaultTags : BoxTags
defaultTags =
    BoxTags Nothing Nothing Nothing Nothing Nothing False


box : BoxTags -> Html Msg
box { tag, stag, mtag, ltag, xltag, tall } =
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
        []


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
                | small = Just { bp | span = s }
                , medium = Just { bp | span = m }
                , large = Just { bp | span = l }
                , extraLarge = Just { bp | span = xl }
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


borderedBox : List (Html Msg) -> Html Msg
borderedBox content =
    div [ class "bordered-box" ] content


spannedProps : Int -> Grid.GridColumnProps
spannedProps n =
    Grid.setSpan n colProps


taggedBox : String -> Html Msg
taggedBox tag =
    box
        { defaultTags
            | tag = Just tag
        }


tallTaggedBox : String -> Html Msg
tallTaggedBox tag =
    box
        { defaultTags
            | tag = Just tag
            , tall = True
        }


tallBox : BoxTags -> Html Msg
tallBox tags =
    box { tags | tall = True }


horizontalAlignment : Html Msg
horizontalAlignment =
    div
        []
        [ h5 [] [ text "Horizontal Alignment" ]
        , p [] [ text "You can align groups of columns on the X-axis" ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HStart }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-start" ] ]
            ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HEnd }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-end" ] ]
            ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HCenter }
                [ Grid.gridColumn (spannedProps 6) [ taggedBox "-x-center" ] ]
            ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceAround }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-around" ]
                , Grid.gridColumn (spannedProps 4) [ taggedBox "-x-around" ]
                ]
            ]
        , borderedBox
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
            Grid.setBreakpointHorizontalAlignment Grid.HStart bp
                |> Grid.setBreakpointSpan 2

        centerBp =
            Grid.setBreakpointHorizontalAlignment Grid.HCenter bp
                |> Grid.setBreakpointSpan 2

        endBp =
            Grid.setBreakpointHorizontalAlignment Grid.HEnd bp
                |> Grid.setBreakpointSpan 2

        props s =
            { colProps
                | small = Just s
            }
    in
    div
        []
        [ h5 [] [ text "Child Alignment Overrides" ]
        , p [] [ text "These classes can be used on ef-col items for finer grained alignment control. Again these are settable per breakpoint, use the -s version to apply to all. Note that using these will use up the available space between flex items, effectively pushing siblings aside." ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HSpaceBetween }
                [ Grid.gridColumn (spannedProps 2) [ taggedBox "-x-between" ]
                , Grid.gridColumn (props startBp) [ taggedBox "-s-x-start" ]
                , Grid.gridColumn (spannedProps 2) [ box defaultTags ]
                ]
            ]
        , borderedBox
            [ Grid.gridRow { rowProps | horizontalAlignment = Grid.HStart }
                [ Grid.gridColumn (spannedProps 2) [ taggedBox "-x-start" ]
                , Grid.gridColumn (spannedProps 2) [ box defaultTags ]
                , Grid.gridColumn (props centerBp) [ taggedBox "-s-x-center" ]
                ]
            ]
        , borderedBox
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
        , borderedBox
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VStretch }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-stretch" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
        , borderedBox
            [ Grid.gridRow { rowProps | verticalAlignment = Grid.VTop }
                [ Grid.gridColumn (spannedProps 4) [ taggedBox "-x-top" ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                , Grid.gridColumn (spannedProps 4) [ box defaultTags ]
                ]
            ]
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
        ]
