module CalendarComponent exposing
    ( Model
    , Msg
    , calendar
    , init
    , nextWeek
    , prevWeek
    , update
    )

import Calendar exposing (Date, decrementDay, fromPosix, getDay, getWeekday, incrementDay)
import Css exposing (..)
import DateTime exposing (getDate)
import Html as Unstyled
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import List
import Time exposing (Posix, Weekday(..))
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


type Msg
    = NoOp


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


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


calendar : Model -> Unstyled.Html Msg
calendar model =
    toUnstyled <|
        case model.mode of
            WeekView ->
                weekView model

            MonthView ->
                monthView model

            DayView ->
                dayView model


weekView : Model -> Html Msg
weekView model =
    let
        currentDay =
            fromPosix model.now

        days =
            getWeek model.start []
    in
    div
        []
        [ weekHeader model days ]


weekHeader : Model -> List Date -> Html Msg
weekHeader model days =
    let
        today =
            fromPosix model.now
    in
    div
        [ css [ displayFlex, justifyContent spaceAround ] ]
        (List.map
            (\d ->
                div
                    [ css
                        [ Css.textAlign center
                        , Css.width (pct 12.5)
                        , whiteSpace noWrap
                        , Css.backgroundColor
                            (if d == today then
                                rgba 90 90 90 0.5

                             else
                                rgb 255 255 255
                            )
                        ]
                    ]
                    [ span [ css [ fontSize (px 28), fontWeight bold ] ] [ text <| String.fromInt <| getDay d ]
                    , text <| " " ++ (weekdayToString <| getWeekday d)
                    ]
            )
            days
        )


monthView : Model -> Html Msg
monthView model =
    div
        []
        [ text "TODO: Month view" ]


dayView : Model -> Html Msg
dayView model =
    div
        []
        [ text "TODO: Day view" ]


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


prevWeek : Model -> Model
prevWeek model =
    { model | start = decrementDay model.start }


nextWeek : Model -> Model
nextWeek model =
    { model | start = incrementDay model.start }
