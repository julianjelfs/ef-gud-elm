module Stories.Pagination exposing (Model, Msg, init, update, view)

import Components.Container as C
import Components.Pagination as P
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { page : Int }


type Msg
    = OnPage Int


init : Model
init =
    { page = 3 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPage page ->
            ( { model | page = page }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ T.light ] [ text "The pagination component allows users to navigate multi-page content. For this component we currently just provide the styling with some dummy content" ]
        , P.pager P.Large { page = model.page, pages = 10, onPage = OnPage }
        , br [] []
        , P.pager P.Small { page = model.page, pages = 10, onPage = OnPage }
        ]
