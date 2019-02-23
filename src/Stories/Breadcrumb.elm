module Stories.Breadcrumb exposing (Model, Msg, init, update, view)

import Components.Breadcrumb as B
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
        [ T.h4 [] [ text "This is the breadcrumb component" ]
        , B.breadcrumbs
            [ B.crumb [] "Home"
            , B.crumb [ B.href "#", B.onClick OnClick ] "Host a student"
            , B.crumb [ B.active ] "Philadelphia"
            ]
        , div [ style "margin-top" "50px" ] [ code [] [ text <| "Number of Clicks: " ++ String.fromInt model.numClicks ] ]
        ]
