module CalendarComponent exposing
    ( Model
    , calendar
    , init
    , nextWeek
    , prevWeek
    , summaryText
    )

import Calendar exposing (Date, decrementDay, fromPosix, getDay, getMonth, getWeekday, getYear, incrementDay)
import Css exposing (..)
import DateTime exposing (getDate)
import Html as Unstyled
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import List
import Time exposing (Month(..), Posix, Weekday(..))
import Utils exposing (..)


type TimeRange
    = TimeRange Int Int


type Timezone
    = Timezone String -- not sure what type this should wrap really


type Mode
    = DayView
    | WeekView
    | MonthView


type alias Model =
    { timeRange : TimeRange
    , timezone : Timezone
    , blockHeight : Float
    , now : Posix
    , mode : Mode
    , start : Date
    }



{- Styles -}


todayColStyle : Style
todayColStyle =
    Css.batch
        [ Css.borderTop3 (px 4) solid (hex "2962ff")
        , Css.boxShadow5 (px 0) (px 2) (px 16) (px 0) (rgba 25 25 25 0.16)
        , Css.borderTopLeftRadius (px 4)
        , Css.borderTopRightRadius (px 4)
        ]


colBorderStyle : Style
colBorderStyle =
    Css.batch
        [ Css.flex (int 1)
        , Css.textAlign Css.center
        , Css.minHeight (px 750)
        , Css.backgroundColor (rgb 255 255 255)
        , Css.borderTop3 (px 1) solid (rgba 25 25 25 0.1)
        , Css.borderBottom3 (px 1) solid (rgba 25 25 25 0.1)
        , Css.borderLeft3 (px 1) solid (rgba 25 25 25 0.1)
        , Css.lastChild
            [ Css.borderRight3 (px 1) solid (rgba 25 25 25 0.1) ]
        ]


headerCellStyle : Style
headerCellStyle =
    Css.batch
        [ Css.padding2 (px 18) (px 18)
        , Css.whiteSpace Css.noWrap
        , Css.borderBottom3 (px 1) solid (rgba 25 25 25 0.1)
        ]


init : Posix -> Model
init now =
    let
        mode =
            WeekView
    in
    { timeRange = TimeRange 7 18
    , timezone = Timezone "GMT"
    , blockHeight = 50.0
    , now = now
    , mode = mode
    , start =
        case mode of
            WeekView ->
                getNearestMonday <| fromPosix now

            DayView ->
                fromPosix now

            MonthView ->
                fromPosix now

    -- TODO this should be the beginning of the month
    }


getNearestMonday : Date -> Date
getNearestMonday d =
    case getWeekday d of
        Mon ->
            d

        _ ->
            getNearestMonday (decrementDay d)


getWeek : Date -> List Date -> List Date
getWeek from dates =
    if List.length dates < 7 then
        getWeek (incrementDay from) (from :: dates)

    else
        List.reverse dates


calendar : Model -> Unstyled.Html msg
calendar model =
    toUnstyled <|
        case model.mode of
            WeekView ->
                weekView model

            MonthView ->
                monthView model

            DayView ->
                dayView model


weekView : Model -> Html msg
weekView model =
    let
        currentDay =
            fromPosix model.now

        days =
            getWeek model.start []
    in
    div
        []
        [ weekHeader model days
        ]


weekHeader : Model -> List Date -> Html msg
weekHeader model days =
    let
        today =
            fromPosix model.now
    in
    div
        [ css
            [ displayFlex ]
        ]
        (List.map
            (\d ->
                div
                    [ css
                        ([ colBorderStyle ] |> appendIf (d == today) todayColStyle)
                    ]
                    [ div
                        [ css [ headerCellStyle ] ]
                        [ span [ css [ fontSize (px 28), fontWeight bold ] ] [ text <| String.fromInt <| getDay d ]
                        , text <| " " ++ (weekdayToString <| getWeekday d)
                        ]
                    ]
            )
            days
        )


monthView : Model -> Html msg
monthView model =
    div
        []
        [ text "TODO: Month view" ]


dayView : Model -> Html msg
dayView model =
    div
        []
        [ text "TODO: Day view" ]


prevWeek : Model -> Model
prevWeek model =
    { model | start = decrementDays 7 model.start }


nextWeek : Model -> Model
nextWeek model =
    { model | start = incrementDays 7 model.start }


incrementDays : Int -> Date -> Date
incrementDays step date =
    if step > 0 then
        incrementDays (step - 1) (incrementDay date)

    else
        date


decrementDays : Int -> Date -> Date
decrementDays step date =
    if step > 0 then
        decrementDays (step - 1) (decrementDay date)

    else
        date


summaryText : Model -> String
summaryText model =
    let
        d =
            getDay model.start

        m =
            getMonth model.start

        y =
            getYear model.start
    in
    String.fromInt d ++ " " ++ monthToString m ++ " " ++ String.fromInt y


monthToString : Month -> String
monthToString m =
    case m of
        Jan ->
            "Jan"

        Feb ->
            "Feb"

        Mar ->
            "Mar"

        Apr ->
            "Apr"

        May ->
            "May"

        Jun ->
            "Jun"

        Jul ->
            "Jul"

        Aug ->
            "Aug"

        Sep ->
            "Sep"

        Oct ->
            "Oct"

        Nov ->
            "Nov"

        Dec ->
            "Jan"


weekdayToString : Weekday -> String
weekdayToString w =
    case w of
        Mon ->
            "Mon"

        Tue ->
            "Tues"

        Wed ->
            "Wed"

        Thu ->
            "Thur"

        Fri ->
            "Fri"

        Sat ->
            "Sat"

        Sun ->
            "Sun"
