module Stories.Accordion exposing (Model, Msg, init, update, view)

import Accordion as A
import Button as B
import Spacing as S
import Typography as T
import Utils exposing (loremIpsum)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task


type alias Model =
    { acc : A.Model
    , numClicks : Int
    }


type Msg
    = AccordionMsg (A.Msg Msg)
    | ButtonClick


init : Model
init =
    { acc = A.init
    , numClicks = 0
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AccordionMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    A.update subMsg model.acc
            in
            ( { model | acc = subModel }, subCmd )

        ButtonClick ->
            ( { model | numClicks = model.numClicks + 1 }, Cmd.none )


accordion : Model -> Html Msg
accordion model =
    div
        [ style "width" "700px" ]
        [ Html.map AccordionMsg <|
            A.accordion model.acc
                [ A.margin [ S.Medium, S.Medium, S.Medium, S.Zero ] ]
                [ A.item "Title One" (A.content [ T.h3 [] [ text "Section One" ], text loremIpsum ])
                , A.item "Title Two" (A.content [ T.h3 [] [ text "Section Two" ], text loremIpsum ])
                , A.item "Title Three" (A.content [ T.h3 [] [ text "Section Three" ], text loremIpsum ])
                , A.item "Title Four"
                    (A.content
                        [ T.h3 [] [ text "Section Four" ]
                        , T.para [] [ text "This section contains a button to click to show that interactions are also easy enough" ]
                        , B.button [ B.primary, B.onClick ButtonClick ] [ text "Click me!" ]
                        ]
                    )
                ]
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ T.light ] [ text "The accordion component is used to show and hide blocks of secondary content which might otherwise clutter the UI" ]
        , T.para [] [ text "Since an accordion requires a small amount of state it is implemented as an Elm component with a full lifecycle of its own" ]
        , accordion model
        , div [] [ code [] [ text <| "Number of Clicks: " ++ String.fromInt model.numClicks ] ]
        ]
