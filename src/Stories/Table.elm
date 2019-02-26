module Stories.Table exposing (view)

import Table as T
import Typography as Ty
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Html msg
view =
    let
        row =
            T.row
                [ T.cell [] [ text "lorem" ]
                , T.cell [] [ text "ipsum" ]
                , T.cell [] [ text "dolor" ]
                , T.cell [] [ text "sit" ]
                , T.cell [] [ text "amet" ]
                , T.cell [] [ text "consectetur" ]
                ]

        header =
            T.header
                [ T.cell [] [ text "One" ]
                , T.cell [] [ text "Two" ]
                , T.cell [] [ text "Three" ]
                , T.cell [] [ text "Four" ]
                , T.cell [] [ text "Five" ]
                , T.cell [] [ text "Six" ]
                ]

        footer =
            T.footer
                [ T.cell [ T.span 6 ] [ strong [] [ text "Total: " ], text "Yawn" ]
                ]
    in
    div
        []
        [ Ty.h4 [] [ text "This is the table component" ]
        , T.table
            (Just header)
            (T.body
                [ row
                , row
                , row
                , row
                , row
                , row
                ]
            )
            (Just footer)
        ]
