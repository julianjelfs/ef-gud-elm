module Stories.Surface exposing (Model, Msg, init, update, view)

import Breakpoint as BP
import Color as C
import Components.Surface as S
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Padding as PD
import Utils exposing (loremIpsum)


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
    div []
        [ div
            [ class <| PD.paddingClass BP.Small PD.Medium ""
            , class <| C.backgroundClass C.HelloPaper
            ]
            [ S.surface False
                []
                [ h3 [] [ text "This stuff is inside a boring surface" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.EfGrey
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ S.surface False
                [ S.outline ]
                [ h3 [] [ text "A surface can have an outline" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.LegalPaper
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ S.surface False
                [ S.shadow ]
                [ h3 [] [ text "Or it can have a shadow" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.OutdoorPaper
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ S.surface False
                [ S.deepShadow ]
                [ h3 [] [ text "And even a DEEP shadow" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.White
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ S.surface False
                [ S.deepShadow, S.rounded ]
                [ h3 [] [ text "And we can also have round corners" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.EfGrey
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ S.surface
                True
                [ S.onClick OnClick ]
                [ h3 [] [ text "We get interaction states if we wrap an <a> tag" ]
                , p []
                    [ text "Number of clicks: "
                    , span [] [ text <| String.fromInt model.numClicks ]
                    ]
                , p [] [ text loremIpsum ]
                ]
            ]
        ]
