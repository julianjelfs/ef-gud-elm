module Stories.Stack exposing (view)

import Color as C
import Grid as G
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as SP
import Stack as S
import Stories.Utils exposing (..)
import Typography as T


simpleStack : Html msg
simpleStack =
    div
        []
        [ h5 [] [ text "Simple Stack" ]
        , p [] [ text "By default, the stack wrapper just piles stack items on top of each other, like any other div. Note that it doesn't handle spacing between items - as elsewhere this should be handled with utility classes." ]
        , borderedBox False
            [ S.stack []
                [ S.item [] [ taggedBox "ef-stack__item" ]
                , S.item [] [ taggedBox "ef-stack__item" ]
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
            [ S.stack
                [ S.vTop ]
                [ S.item [] [ taggedBox "-start" ]
                , S.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ S.stack
                [ S.vBetween ]
                [ S.item [] [ taggedBox "-between" ]
                , S.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ S.stack
                [ S.vAround ]
                [ S.item [] [ taggedBox "-around" ]
                , S.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ S.stack
                [ S.vBottom ]
                [ S.item [] [ taggedBox "-end" ]
                , S.item [] [ box defaultTags ]
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
            [ S.stack
                [ S.vTop ]
                [ S.item
                    [ S.itemStretch ]
                    [ taggedBox "-stretch" ]
                , S.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ S.stack
                [ S.vAround ]
                [ S.item
                    [ S.itemTop ]
                    [ taggedBox "-start" ]
                , S.item [] [ box defaultTags ]
                ]
            ]
        , borderedBox True
            [ S.stack
                [ S.vAround ]
                [ S.item [] [ box defaultTags ]
                , S.item
                    [ S.itemBottom ]
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
            [ S.itemStretch
            , S.spacing Nothing SP.Margin SP.Bottom SP.Small
            ]

        tile =
            div [ style "min-height" "100px" ] []
    in
    div
        []
        [ h5 [] [ text "Full Layout" ]
        , p [] [ text "As mentioned above, it's possible to combine stacks with grids to build tile-based UIs like the following." ]
        , G.row []
            [ G.col [ G.smallSpan 12, G.mediumSpan 12, G.largeSpan 8 ]
                [ S.stack []
                    [ S.item []
                        [ G.row []
                            [ G.col []
                                [ S.stack []
                                    [ S.item (S.bgColor C.EducationBlue :: stretchProps)
                                        [ tile ]
                                    , S.item (S.bgColor C.DigitalFirstBlue :: stretchProps)
                                        [ tile ]
                                    ]
                                ]
                            , G.col []
                                [ S.stack []
                                    [ S.item (S.bgColor C.HelloPink :: stretchProps)
                                        [ tile ]
                                    ]
                                ]
                            ]
                        ]
                    , S.item (S.bgColor C.EducationBlue :: stretchProps)
                        [ tile ]
                    ]
                ]
            , G.col []
                [ S.stack []
                    [ S.item (S.bgColor C.DigitalFirstBlue :: stretchProps)
                        [ tile ]
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
