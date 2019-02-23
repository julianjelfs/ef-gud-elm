module Stories.Link exposing (Model, Msg, init, update, view)

import Components.Link as Link
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { numClicks : Int }


type Msg
    = OnClick


init : Model
init =
    { numClicks = 0 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnClick ->
            ( { model | numClicks = model.numClicks + 1 }, Cmd.none )


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [] [ text "This is the link component" ]
        , p []
            [ span [] [ text "The link component is ideal if you have a chunk text and " ]
            , Link.link { href = "#", onClick = Just OnClick }
                [ text "it needs to have a Link!" ]
            , span [] [ text " in the middle of it" ]
            ]
        , p []
            [ text "You can supply a click handler if you want or let the router handle it" ]
        , p []
            [ text <| "Number of clicks: " ++ String.fromInt model.numClicks ]
        ]
