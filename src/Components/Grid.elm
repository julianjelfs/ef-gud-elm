module Components.Grid exposing
    ( col
    , defaultSpan
    , extraLargeCollapse
    , extraLargeFirst
    , extraLargeLast
    , extraLargeOffset
    , extraLargeShrink
    , extraLargeSpan
    , extralargexcenter
    , extralargexend
    , extralargexstart
    , extralargeybottom
    , extralargeycenter
    , extralargeytop
    , largeCollapse
    , largeFirst
    , largeLast
    , largeOffset
    , largeShrink
    , largeSpan
    , largexcenter
    , largexend
    , largexstart
    , largeybottom
    , largeycenter
    , largeytop
    , mediumCollapse
    , mediumFirst
    , mediumLast
    , mediumOffset
    , mediumShrink
    , mediumSpan
    , mediumxcenter
    , mediumxend
    , mediumxstart
    , mediumybottom
    , mediumycenter
    , mediumytop
    , row
    , smallCollapse
    , smallFirst
    , smallLast
    , smallOffset
    , smallShrink
    , smallSpan
    , smallxcenter
    , smallxend
    , smallxstart
    , smallybottom
    , smallycenter
    , smallytop
    , xaround
    , xbetween
    , xcenter
    , xend
    , xstart
    , ybottom
    , ycenter
    , ystretch
    , ytop
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type RowProp msg
    = RowProp (Attribute msg)


type ColProp msg
    = ColProp (Attribute msg)


type Column msg
    = Column (Html msg)


type Row msg
    = Row (Html msg)


row : List (RowProp msg) -> List (Column msg) -> Html msg
row props cols =
    div
        ([ class "ef-row" ] ++ List.map (\(RowProp a) -> a) props)
        (List.map (\(Column c) -> c) cols)


col : List (ColProp msg) -> List (Html msg) -> Column msg
col props content =
    Column <|
        div
            ([ class "ef-col" ] ++ List.map (\(ColProp a) -> a) props)
            content


xstart : RowProp msg
xstart =
    rowClass "-x-start"


xaround : RowProp msg
xaround =
    rowClass "-x-around"


xbetween : RowProp msg
xbetween =
    rowClass "-x-between"


xend : RowProp msg
xend =
    rowClass "-x-end"


xcenter : RowProp msg
xcenter =
    rowClass "-x-center"


ystretch : RowProp msg
ystretch =
    rowClass "-y-stretch"


ytop : RowProp msg
ytop =
    rowClass "-y-top"


ycenter : RowProp msg
ycenter =
    rowClass "-y-center"


ybottom : RowProp msg
ybottom =
    rowClass "-y-bottom"


smallSpan : Int -> ColProp msg
smallSpan =
    bpSpan "s"


smallFirst : ColProp msg
smallFirst =
    bpFirst "s"


mediumFirst : ColProp msg
mediumFirst =
    bpFirst "m"


largeFirst : ColProp msg
largeFirst =
    bpFirst "l"


extraLargeFirst : ColProp msg
extraLargeFirst =
    bpFirst "xl"


smallShrink : ColProp msg
smallShrink =
    bpShrink "s"


mediumShrink : ColProp msg
mediumShrink =
    bpShrink "m"


largeShrink : ColProp msg
largeShrink =
    bpShrink "l"


extraLargeShrink : ColProp msg
extraLargeShrink =
    bpShrink "xl"


smallCollapse : ColProp msg
smallCollapse =
    bpCollapse "s"


mediumCollapse : ColProp msg
mediumCollapse =
    bpCollapse "m"


largeCollapse : ColProp msg
largeCollapse =
    bpCollapse "l"


extraLargeCollapse : ColProp msg
extraLargeCollapse =
    bpCollapse "xl"


smallLast : ColProp msg
smallLast =
    bpLast "s"


mediumLast : ColProp msg
mediumLast =
    bpLast "m"


largeLast : ColProp msg
largeLast =
    bpLast "l"


extraLargeLast : ColProp msg
extraLargeLast =
    bpLast "xl"


defaultSpan : Int -> ColProp msg
defaultSpan =
    smallSpan


mediumSpan : Int -> ColProp msg
mediumSpan =
    bpSpan "m"


largeSpan : Int -> ColProp msg
largeSpan =
    bpSpan "l"


extraLargeSpan : Int -> ColProp msg
extraLargeSpan =
    bpSpan "xl"


smallOffset : Int -> ColProp msg
smallOffset =
    bpOffset "s"


mediumOffset : Int -> ColProp msg
mediumOffset =
    bpOffset "m"


largeOffset : Int -> ColProp msg
largeOffset =
    bpOffset "l"


extraLargeOffset : Int -> ColProp msg
extraLargeOffset =
    bpOffset "xl"


smallytop : ColProp msg
smallytop =
    bpString "y-top" "s"


mediumytop : ColProp msg
mediumytop =
    bpString "y-top" "m"


largeytop : ColProp msg
largeytop =
    bpString "y-top" "l"


extralargeytop : ColProp msg
extralargeytop =
    bpString "y-top" "xl"


smallycenter : ColProp msg
smallycenter =
    bpString "y-center" "s"


mediumycenter : ColProp msg
mediumycenter =
    bpString "y-center" "m"


largeycenter : ColProp msg
largeycenter =
    bpString "y-center" "l"


extralargeycenter : ColProp msg
extralargeycenter =
    bpString "y-center" "xl"


smallybottom : ColProp msg
smallybottom =
    bpString "y-bottom" "s"


mediumybottom : ColProp msg
mediumybottom =
    bpString "y-bottom" "m"


largeybottom : ColProp msg
largeybottom =
    bpString "y-bottom" "l"


extralargeybottom : ColProp msg
extralargeybottom =
    bpString "y-bottom" "xl"


smallxstart : ColProp msg
smallxstart =
    bpString "x-start" "s"


smallxcenter : ColProp msg
smallxcenter =
    bpString "x-center" "s"


smallxend : ColProp msg
smallxend =
    bpString "x-end" "s"


mediumxstart : ColProp msg
mediumxstart =
    bpString "x-start" "m"


mediumxcenter : ColProp msg
mediumxcenter =
    bpString "x-center" "m"


mediumxend : ColProp msg
mediumxend =
    bpString "x-end" "m"


largexstart : ColProp msg
largexstart =
    bpString "x-start" "l"


largexcenter : ColProp msg
largexcenter =
    bpString "x-center" "l"


largexend : ColProp msg
largexend =
    bpString "x-end" "l"


extralargexstart : ColProp msg
extralargexstart =
    bpString "x-start" "xl"


extralargexcenter : ColProp msg
extralargexcenter =
    bpString "x-center" "xl"


extralargexend : ColProp msg
extralargexend =
    bpString "x-end" "xl"


bpSpan : String -> Int -> ColProp msg
bpSpan bp n =
    ColProp <| class <| "-" ++ bp ++ "-" ++ String.fromInt n


bpOffset : String -> Int -> ColProp msg
bpOffset bp n =
    ColProp <| class <| "-" ++ bp ++ "-offset-" ++ String.fromInt n


bpString : String -> String -> ColProp msg
bpString cls bp =
    ColProp <| class <| "-" ++ bp ++ "-" ++ cls


bpCollapse : String -> ColProp msg
bpCollapse =
    bpString "collapse"


bpShrink : String -> ColProp msg
bpShrink =
    bpString "shrink"


bpFirst : String -> ColProp msg
bpFirst =
    bpString "first"


bpLast : String -> ColProp msg
bpLast =
    bpString "last"


rowClass : String -> RowProp msg
rowClass =
    class >> RowProp
