module Stories.Surface exposing (Model, Msg, init, update, view)

import Breakpoint as BP
import Color as C
import Components.Surface as Surface
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Padding as PD


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
        [ class <| PD.paddingClass BP.Small PD.Medium
        , class <| C.backgroundClass C.HelloPaper
        ]
        [ Surface.surface {}
            [ h3 [] [ text "This stuff is inside a boring surface" ]
            , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis convallis eros. Curabitur nulla mi, aliquet vel tempor a, pharetra ac massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis venenatis elit sed tempus rhoncus. Donec a quam dignissim, fermentum neque varius, porttitor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum lacinia venenatis nunc, a vehicula enim dictum eget. Etiam at elit turpis. In at pretium velit, quis blandit metus. Duis cursus orci eget tortor venenatis condimentum. Aenean semper sollicitudin eros sed vulputate. Morbi vehicula ut neque vitae faucibus. Duis non sollicitudin elit." ]
            ]
        ]
