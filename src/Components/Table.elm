module Table exposing (body, cell, footer, header, row, span, table)

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type TableHeader msg
    = TableHeader (List (TableCell msg))


type TableBody msg
    = TableBody (List (TableRow msg))


type TableFooter msg
    = TableFooter (List (TableCell msg))


type TableRow msg
    = TableRow (List (TableCell msg))


type TableCell msg
    = TableCell (List (TableCellProp msg)) (List (Html msg))


type TableCellProp msg
    = TableCellProp (Attribute msg)


span : Int -> TableCellProp msg
span =
    TableCellProp << colspan


header : List (TableCell msg) -> TableHeader msg
header =
    TableHeader


body : List (TableRow msg) -> TableBody msg
body =
    TableBody


footer : List (TableCell msg) -> TableFooter msg
footer =
    TableFooter


row : List (TableCell msg) -> TableRow msg
row =
    TableRow


cell : List (TableCellProp msg) -> List (Html msg) -> TableCell msg
cell =
    TableCell


table : Maybe (TableHeader msg) -> TableBody msg -> Maybe (TableFooter msg) -> Html msg
table h b f =
    Html.table
        [ class "ef-table" ]
        ([]
            |> maybeAppend (renderHeader h)
            |> flip List.append [ renderBody b ]
            |> maybeAppend (renderFooter f)
        )


renderHeader : Maybe (TableHeader msg) -> Maybe (Html msg)
renderHeader =
    Maybe.map
        (\(TableHeader cells) ->
            thead
                []
                [ tr
                    []
                    (List.map (renderCell th) cells)
                ]
        )


renderFooter : Maybe (TableFooter msg) -> Maybe (Html msg)
renderFooter =
    Maybe.map
        (\(TableFooter cells) ->
            tfoot
                []
                [ tr
                    []
                    (List.map (renderCell td) cells)
                ]
        )


renderBody : TableBody msg -> Html msg
renderBody (TableBody rows) =
    tbody
        []
        (List.map renderRow rows)


renderRow : TableRow msg -> Html msg
renderRow (TableRow cells) =
    tr
        []
        (List.map (renderCell td) cells)


renderCell : (List (Attribute msg) -> List (Html msg) -> Html msg) -> TableCell msg -> Html msg
renderCell elem (TableCell props content) =
    elem
        (List.map (\(TableCellProp a) -> a) props)
        content
