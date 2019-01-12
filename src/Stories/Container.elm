module Stories.Container exposing (Model, Msg, init, update, view)

import Components.Container as Container
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, disabled, href, src)
import Html.Styled.Events exposing (onClick)


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
        , div [ css paddedBox ] [ Container.container [] ]
        ]


paddedBox : List Style
paddedBox =
    [ padding (px 10) ]
