module Stories.Typography exposing (Model, Msg, init, update, view)

import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


h1 : Html Msg
h1 =
    T.h1 [ text "Lorem ipsum dolor sit amet, consetetur" ]


h2 : Html Msg
h2 =
    T.h2 [ text "Lorem ipsum dolor sit amet, consetetur" ]


h3 : Html Msg
h3 =
    T.h3 [ text "Lorem ipsum dolor sit amet, consetetur" ]


h4 : Html Msg
h4 =
    T.h4 [ text "Lorem ipsum dolor sit amet, consetetur" ]


h5 : Html Msg
h5 =
    T.h5 [ text "Lorem ipsum dolor sit amet, consetetur" ]


h6 : Html Msg
h6 =
    T.h6 [ text "Lorem ipsum dolor sit amet, consetetur" ]


subtitle : Html Msg
subtitle =
    T.subtitle [ text "Lorem ipsum dolor sit amet, consetetur" ]


body : Html Msg
body =
    T.body [ text "Lorem ipsum dolor sit amet, consetetur" ]


bodyBook : Html Msg
bodyBook =
    T.bodyBook [ text "Lorem ipsum dolor sit amet, consetetur" ]


para : Html Msg
para =
    T.para [ text "Lorem ipsum dolor sit amet, consetetur" ]


paraBook : Html Msg
paraBook =
    T.paraBook [ text "Lorem ipsum dolor sit amet, consetetur" ]


view : Model -> Html Msg
view model =
    div
        []
        [ Html.h3 [] [ text "These are the typography elements" ]
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , subtitle
        , body
        , bodyBook
        , para
        , paraBook
        ]
