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
    }


defaultTags : BoxTags
defaultTags =
    BoxTags Nothing Nothing Nothing Nothing Nothing


box : BoxTags -> Html Msg
box { tag, stag, mtag, ltag, xltag } =
    div
        ([ class "docs-box"
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
    let
        rowProps =
            Grid.defaultRowProps

        colProps =
            Grid.defaultColProps

        taggedBox =
            box
                { defaultTags
                    | tag =
                        Just
                            "ef-col"
                }
    in
    div
        []
        [ h5 [] [ text "Auto widths" ]
        , p [] [ text "By default columns fill an equal amount of the available        space. If you add two, they will be 50% wide each. Simple" ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps
                [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
            ]
        , Grid.gridRow rowProps
            [ Grid.gridColumn colProps [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
            , Grid.gridColumn colProps [ taggedBox ]
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
        rowProps =
            Grid.defaultRowProps

        colProps =
            Grid.defaultColProps

        props s m l xl =
            { colProps
                | small = Just { span = s }
                , medium = Just { span = m }
                , large = Just { span = l }
                , extraLarge = Just { span = xl }
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


view : Model -> Html Msg
view model =
    Container.container
        [ h3 [] [ text "This is the grid component" ]
        , autoWidths
        , br [] []
        , responsiveWidths
        ]
