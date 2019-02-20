module Stories.Accordion exposing (Model, Msg, init, update, view)

import Components.Accordion as A
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (loremIpsum)


type alias Model =
    { acc : A.Model }


type Msg
    = AccordionMsg A.Msg


init : Model
init =
    { acc = A.init }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AccordionMsg subMsg ->
            let
                subModel =
                    A.update subMsg model.acc
            in
            ( { model | acc = subModel }, Cmd.none )


accordion : Model -> Html Msg
accordion model =
    div
        [ style "width" "700px" ]
        [ Html.map AccordionMsg <|
            A.accordion model.acc
                [ A.margin [ S.Medium, S.Medium, S.Medium, S.Zero ] ]
                [ A.item "Title One" (A.content [ text loremIpsum ])
                , A.item "Title Two" (A.content [ text loremIpsum ])
                , A.item "Title Three" (A.content [ text loremIpsum ])
                ]
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ T.light ] [ text "The accordion component is used to show and hide blocks of secondary content which might otherwise clutter the UI" ]
        , T.para [] [ text "Since an accordion requires a small amount of state it is implemented as an Elm component with a full lifecycle of its own" ]
        , accordion model
        ]
