module Stories.Pagination exposing (Model, Msg, init, update, view)

import Components.Container as C
import Components.Pagination as P
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


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ T.light ] [ text "The pagination component allows users to navigate multi-page content. For this component we currently just provide the styling with some dummy content" ]
        , P.pager P.Large []
        ]
