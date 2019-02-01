module Stories.Select exposing (Model, Msg, init, update, view)

import Components.Select as S
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


options : List S.Option
options =
    [ S.Option "a" "One"
    , S.Option "b" "Two"
    , S.Option "c" "Three"
    , S.Option "d" "Four"
    , S.Option "e" "Five"
    ]


simpleSelect : Html Msg
simpleSelect =
    S.select [] options


selectStates : Html Msg
selectStates =
    S.select [] options


view : Model -> Html Msg
view model =
    div
        []
        [ h3 [] [ text "This is the select component" ]
        , simpleSelect
        , selectStates
        ]
