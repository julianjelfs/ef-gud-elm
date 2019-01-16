module Stories.Container exposing (Model, Msg, init, update, view)

import Components.Container as Container
import Html exposing (..)
import Html.Attributes exposing (disabled, href, src)
import Html.Events exposing (onClick)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ h2 [] [ text "This is the container component" ]
        , div [] [ Container.container [] ]
        ]
