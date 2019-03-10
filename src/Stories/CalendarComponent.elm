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
    Maybe Calendar.Model


type Msg
    = Initialise Posix
    | PreviousWeek
    | NextWeek


init : ( Model, Cmd Msg )
init =
    ( Nothing, Task.perform Initialise Time.now )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Initialise p ->
            ( Just <| Calendar.init p, Cmd.none )

        PreviousWeek ->
            ( Maybe.map Calendar.prevWeek model, Cmd.none )

        NextWeek ->
            ( Maybe.map Calendar.nextWeek model, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        Nothing ->
            text ""

        Just m ->
            div
                []
                [ G.row []
                    [ G.col [ G.smallSpan 3 ]
                        [ B.button [ B.secondary, B.onClick PreviousWeek ] [ text "Previous Week" ] ]
                    , G.col [ G.smallSpan 6 ]
                        [ div [ class "u-pt-s u-xy-abs-center" ]
                            [ T.h5 [] [ text <| Calendar.summaryText m ] ]
                        ]
                    , G.col [ G.smallSpan 3, G.smallXEnd, G.smallShrink ]
                        [ B.button [ B.secondary, B.onClick NextWeek ] [ text "Next Week" ] ]
                    ]
                , br [] []
                , Calendar.calendar m
                ]
