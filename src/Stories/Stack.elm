module Stories.Stack exposing (Model, Msg, init, update, view)

import Components.Grid as Grid
import Components.Stack as Stack
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Stories.Utils exposing (..)


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


defaultStackProps =
    Stack.defaultStackProps


defaultItemProps =
    Stack.defaultStackItemProps


simpleStack : Html Msg
simpleStack =
    div
        []
        [ h5 [] [ text "Simple Stack" ]
        , p [] [ text "By default, the stack wrapper just piles stack items on top of each other, like any other div. Note that it doesn't handle spacing between items - as elsewhere this should be handled with utility classes." ]
        , borderedBox False
            [ Stack.stack defaultStackProps
                [ Stack.stackItem defaultItemProps [ taggedBox "ef-stack__item" ]
                , Stack.stackItem defaultItemProps [ taggedBox "ef-stack__item" ]
                ]
            ]
        ]


stackAlignment : Html Msg
stackAlignment =
    div
        []
        [ h5 [] [ text "Stack Alignment" ]
        , p [] [ text "The stack component starts to become useful when aligning items inside arbitrarily tall columns. The modifier classnames mirror the alignment classes in the grid, but since in this case we are only concerned with the y-axis, we drop the y from the classname" ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VStart
                }
                [ Stack.stackItem defaultItemProps [ taggedBox "-start" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VBetween
                }
                [ Stack.stackItem defaultItemProps [ taggedBox "-between" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VAround
                }
                [ Stack.stackItem defaultItemProps [ taggedBox "-around" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VEnd
                }
                [ Stack.stackItem defaultItemProps [ taggedBox "-end" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        ]


itemAlignment : Html Msg
itemAlignment =
    div
        []
        [ h5 [] [ text "Stack Item Alignment" ]
        , p [] [ text "Sometimes you'll need one item to behave differently to its siblings. These modifiers handle those situations." ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VStart
                }
                [ Stack.stackItem
                    { defaultItemProps
                        | alignment = Stack.IStretch
                    }
                    [ taggedBox "-stretch" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VAround
                }
                [ Stack.stackItem
                    { defaultItemProps
                        | alignment = Stack.IStart
                    }
                    [ taggedBox "-start" ]
                , Stack.stackItem defaultItemProps [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                { defaultStackProps
                    | verticalAlignment = Stack.VAround
                }
                [ Stack.stackItem defaultItemProps [ box defaultTags ]
                , Stack.stackItem
                    { defaultItemProps
                        | alignment = Stack.IEnd
                    }
                    [ taggedBox "-end" ]
                ]
            ]
        ]


coloredBox : String -> Html msg
coloredBox cls =
    box { defaultTags | bgClass = Just cls }


fullLayout : Html Msg
fullLayout =
    let
        stretchProps =
            { defaultItemProps
                | alignment =
                    Stack.IStretch
            }
    in
    div
        []
        [ h5 [] [ text "Full Layout" ]
        , p [] [ text "As mentioned above, it's possible to combine stacks with grids to build tile-based UIs like the following." ]
        , Grid.row []
            [ Grid.col [ Grid.smallSpan 12, Grid.mediumSpan 8 ]
                [ Stack.stack defaultStackProps
                    [ Stack.stackItem stretchProps
                        [ Grid.row []
                            [ Grid.col []
                                [ Stack.stack defaultStackProps
                                    [ Stack.stackItem stretchProps
                                        [ coloredBox "u-bg-education-blue"
                                        ]
                                    , Stack.stackItem stretchProps
                                        [ coloredBox "u-bg-first-blue" ]
                                    ]
                                ]
                            , Grid.col []
                                [ Stack.stack defaultStackProps
                                    [ Stack.stackItem stretchProps
                                        [ coloredBox "u-bg-hello-pink" ]
                                    ]
                                ]
                            ]
                        ]
                    , Stack.stackItem stretchProps
                        [ coloredBox
                            "u-bg-education-blue"
                        ]
                    ]
                ]
            , Grid.col []
                [ Stack.stack defaultStackProps
                    [ Stack.stackItem stretchProps
                        [ coloredBox
                            "u-bg-first-blue"
                        ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div [ class "stack-docs" ]
        [ h3 [] [ text "This is the stack component" ]
        , p []
            [ text "The ef-stack component uses flexbox to handle alignment on the Y-axis. It's far simpler than the grid, but can be combined with it to build complex tile layouts." ]
        , simpleStack
        , br [] []
        , stackAlignment
        , br [] []
        , itemAlignment
        , br [] []
        , fullLayout
        ]
