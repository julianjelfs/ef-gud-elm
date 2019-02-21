module Stories.Pagination exposing (Model, Msg, init, update, view)

import Components.Container as C
import Components.Pagination as P
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { pageIndex : Int }


type Msg
    = OnPage Int


init : Model
init =
    { pageIndex = 0 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPage index ->
            ( { model | pageIndex = index }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ T.light ] [ text "The pagination component allows users to navigate multi-page content. For this component we currently just provide the styling with some dummy content" ]
        , P.pager P.Large { index = model.pageIndex, pages = 10, onPage = OnPage }
        ]
