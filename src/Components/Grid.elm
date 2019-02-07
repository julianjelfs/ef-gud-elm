module Components.Grid exposing
    ( bottomMargin
    , bottomPad
    , col
    , defaultSpan
    , extraLargeCollapse
    , extraLargeFirst
    , extraLargeLast
    , extraLargeOffset
    , extraLargeShrink
    , extraLargeSpan
    , extralargeXCenter
    , extralargeXEnd
    , extralargeXStart
    , extralargeYBottom
    , extralargeYCenter
    , extralargeYTop
    , horizontalMargin
    , largeCollapse
    , largeFirst
    , largeLast
    , largeOffset
    , largeShrink
    , largeSpan
    , largeXCenter
    , largeXEnd
    , largeXStart
    , largeYBottom
    , largeYCenter
    , largeYTop
    , leftMargin
    , mediumCollapse
    , mediumFirst
    , mediumLast
    , mediumOffset
    , mediumShrink
    , mediumSpan
    , mediumXCenter
    , mediumXEnd
    , mediumXStart
    , mediumYBottom
    , mediumYCenter
    , mediumYTop
    , rightMargin
    , row
    , smallCollapse
    , smallFirst
    , smallLast
    , smallOffset
    , smallShrink
    , smallSpan
    , smallXCenter
    , smallXEnd
    , smallXStart
    , smallYBottom
    , smallYCenter
    , smallYTop
    , topMargin
    , verticalMargin
    , xAround
    , xBetween
    , xCenter
    , xEnd
    , xStart
    , yBottom
    , yCenter
    , yStretch
    , yTop
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


type RowProp msg
    = RowProp (Attribute msg)


type ColProp msg
    = ColProp (Attribute msg)


type Column msg
    = Column (Html msg)


type Row msg
    = Row (Html msg)


verticalMargin : S.Spacing -> RowProp msg
verticalMargin =
    RowProp << S.verticalMargin


topMargin : S.Spacing -> RowProp msg
topMargin =
    RowProp << S.topMargin


rightMargin : S.Spacing -> RowProp msg
rightMargin =
    RowProp << S.rightMargin


leftMargin : S.Spacing -> RowProp msg
leftMargin =
    RowProp << S.leftMargin


horizontalMargin : S.Spacing -> RowProp msg
horizontalMargin =
    RowProp << S.horizontalMargin


bottomMargin : S.Spacing -> RowProp msg
bottomMargin =
    RowProp << S.bottomMargin


bottomPad : S.Spacing -> ColProp msg
bottomPad =
    ColProp << S.bottomPad


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


xStart : RowProp msg
xStart =
    rowClass "-x-start"


xAround : RowProp msg
xAround =
    rowClass "-x-around"


xBetween : RowProp msg
xBetween =
    rowClass "-x-between"


xEnd : RowProp msg
xEnd =
    rowClass "-x-end"


xCenter : RowProp msg
xCenter =
    rowClass "-x-center"


yStretch : RowProp msg
yStretch =
    rowClass "-y-stretch"


yTop : RowProp msg
yTop =
    rowClass "-y-start"


yCenter : RowProp msg
yCenter =
    rowClass "-y-center"


yBottom : RowProp msg
yBottom =
    rowClass "-y-end"


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


smallYTop : ColProp msg
smallYTop =
    bpString "y-start" "s"


mediumYTop : ColProp msg
mediumYTop =
    bpString "y-start" "m"


largeYTop : ColProp msg
largeYTop =
    bpString "y-start" "l"


extralargeYTop : ColProp msg
extralargeYTop =
    bpString "y-start" "xl"


smallYCenter : ColProp msg
smallYCenter =
    bpString "y-center" "s"


mediumYCenter : ColProp msg
mediumYCenter =
    bpString "y-center" "m"


largeYCenter : ColProp msg
largeYCenter =
    bpString "y-center" "l"


extralargeYCenter : ColProp msg
extralargeYCenter =
    bpString "y-center" "xl"


smallYBottom : ColProp msg
smallYBottom =
    bpString "y-end" "s"


mediumYBottom : ColProp msg
mediumYBottom =
    bpString "y-end" "m"


largeYBottom : ColProp msg
largeYBottom =
    bpString "y-end" "l"


extralargeYBottom : ColProp msg
extralargeYBottom =
    bpString "y-end" "xl"


smallXStart : ColProp msg
smallXStart =
    bpString "x-start" "s"


smallXCenter : ColProp msg
smallXCenter =
    bpString "x-center" "s"


smallXEnd : ColProp msg
smallXEnd =
    bpString "x-end" "s"


mediumXStart : ColProp msg
mediumXStart =
    bpString "x-start" "m"


mediumXCenter : ColProp msg
mediumXCenter =
    bpString "x-center" "m"


mediumXEnd : ColProp msg
mediumXEnd =
    bpString "x-end" "m"


largeXStart : ColProp msg
largeXStart =
    bpString "x-start" "l"


largeXCenter : ColProp msg
largeXCenter =
    bpString "x-center" "l"


largeXEnd : ColProp msg
largeXEnd =
    bpString "x-end" "l"


extralargeXStart : ColProp msg
extralargeXStart =
    bpString "x-start" "xl"


extralargeXCenter : ColProp msg
extralargeXCenter =
    bpString "x-center" "xl"


extralargeXEnd : ColProp msg
extralargeXEnd =
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
