module Stories.Stack exposing (view)

import Components.Grid as Grid
import Components.Stack as Stack
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Stories.Utils exposing (..)


simpleStack : Html msg
simpleStack =
    div
        []
        [ h5 [] [ text "Simple Stack" ]
        , p [] [ text "By default, the stack wrapper just piles stack items on top of each other, like any other div. Note that it doesn't handle spacing between items - as elsewhere this should be handled with utility classes." ]
        , borderedBox False
            [ Stack.stack []
                [ Stack.item [] [ taggedBox "ef-stack__item" ]
                , Stack.item [] [ taggedBox "ef-stack__item" ]
                ]
            ]
        ]


stackAlignment : Html msg
stackAlignment =
    div
        []
        [ h5 [] [ text "Stack Alignment" ]
        , p [] [ text "The stack component starts to become useful when aligning items inside arbitrarily tall columns. The modifier classnames mirror the alignment classes in the grid, but since in this case we are only concerned with the y-axis, we drop the y from the classname" ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vTop ]
                [ Stack.item [] [ taggedBox "-start" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vBetween ]
                [ Stack.item [] [ taggedBox "-between" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vAround ]
                [ Stack.item [] [ taggedBox "-around" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vBottom ]
                [ Stack.item [] [ taggedBox "-end" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        ]


itemAlignment : Html msg
itemAlignment =
    div
        []
        [ h5 [] [ text "Stack Item Alignment" ]
        , p [] [ text "Sometimes you'll need one item to behave differently to its siblings. These modifiers handle those situations." ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vTop ]
                [ Stack.item
                    [ Stack.itemStretch ]
                    [ taggedBox "-stretch" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vAround ]
                [ Stack.item
                    [ Stack.itemTop ]
                    [ taggedBox "-start" ]
                , Stack.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ Stack.stack
                [ Stack.vAround ]
                [ Stack.item [] [ box defaultTags ]
                , Stack.item
                    [ Stack.itemBottom ]
                    [ taggedBox "-end" ]
                ]
            ]
        ]


coloredBox : String -> Html msg
coloredBox cls =
    box { defaultTags | bgClass = Just cls }


fullLayout : Html msg
fullLayout =
    let
        stretchProps =
            [ Stack.itemStretch ]
    in
    div
        []
        [ h5 [] [ text "Full Layout" ]
        , p [] [ text "As mentioned above, it's possible to combine stacks with grids to build tile-based UIs like the following." ]
        , Grid.row []
            [ Grid.col [ Grid.smallSpan 12, Grid.mediumSpan 8 ]
                [ Stack.stack []
                    [ Stack.item stretchProps
                        [ Grid.row []
                            [ Grid.col []
                                [ Stack.stack []
                                    [ Stack.item stretchProps
                                        [ coloredBox "u-bg-education-blue"
                                        ]
                                    , Stack.item stretchProps
                                        [ coloredBox "u-bg-first-blue" ]
                                    ]
                                ]
                            , Grid.col []
                                [ Stack.stack []
                                    [ Stack.item stretchProps
                                        [ coloredBox "u-bg-hello-pink" ]
                                    ]
                                ]
                            ]
                        ]
                    , Stack.item stretchProps
                        [ coloredBox
                            "u-bg-education-blue"
                        ]
                    ]
                ]
            , Grid.col []
                [ Stack.stack []
                    [ Stack.item stretchProps
                        [ coloredBox
                            "u-bg-first-blue"
                        ]
                    ]
                ]
            ]
        ]


view : Html msg
view =
    div [ class "stack-docs" ]
        [ T.h4 [] [ text "This is the stack component" ]
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
