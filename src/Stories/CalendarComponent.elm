module Stories.CalendarComponent exposing (Model, Msg, init, update, view)

import Button as B
import CalendarComponent as Calendar
import Grid as G
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task
import Time exposing (Posix)
import Typography as T


type alias Model =
    { model : Maybe Calendar.Model }


type Msg
    = CalendarMsg Calendar.Msg
    | Initialise Posix
    | PreviousWeek
    | NextWeek


init : ( Model, Cmd Msg )
init =
    ( { model = Nothing }, Task.perform Initialise Time.now )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CalendarMsg sub ->
            ( model, Cmd.none )

        Initialise p ->
            ( { model | model = Just <| Calendar.init p }, Cmd.none )

        PreviousWeek ->
            let
                updated =
                    Maybe.map Calendar.prevWeek model.model
            in
            ( { model | model = updated }, Cmd.none )

        NextWeek ->
            let
                updated =
                    Maybe.map Calendar.nextWeek model.model
            in
            ( { model | model = updated }, Cmd.none )


view : Model -> Html Msg
view model =
    case model.model of
        Nothing ->
            text ""

        Just m ->
            div
                []
                [ T.h4 [] [ text "This is the calendar component" ]
                , G.row []
                    [ G.col [ G.smallSpan 3 ]
                        [ B.button [ B.secondary, B.onClick PreviousWeek ] [ text "Previous Week" ] ]
                    , G.col [ G.smallSpan 3, G.smallXEnd, G.smallShrink ]
                        [ B.button [ B.secondary, B.onClick NextWeek ] [ text "Next Week" ] ]
                    ]
                , br [] []
                , Html.map CalendarMsg (Calendar.calendar m)
                ]
