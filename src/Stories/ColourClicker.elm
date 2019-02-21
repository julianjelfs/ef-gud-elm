module Stories.ColourClicker exposing (Model, Msg, init, update, view)

import Components.ColourClicker as C
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { cc : C.Model }


type Msg
    = ColourClickerMsg C.Msg


init : Model
init =
    { cc = C.init }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ColourClickerMsg subMsg ->
            let
                subModel =
                    C.update subMsg model.cc
            in
            ( { model | cc = subModel }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ h4 [] [ text "This is an example of render props in Elm" ]
        , C.view model.cc
        ]
