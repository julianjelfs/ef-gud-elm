module Stories.Surface exposing (Model, Msg, init, update, view)

import Breakpoint as BP
import Color as C
import Components.Surface as Surface
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Padding as PD
import Utils exposing (loremIpsum)


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
    let
        d =
            Surface.defaultProps
    in
    div []
        [ div
            [ class <| PD.paddingClass BP.Small PD.Medium ""
            , class <| C.backgroundClass C.HelloPaper
            ]
            [ Surface.surface d
                [ h3 [] [ text "This stuff is inside a boring surface" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.EfGrey
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ Surface.surface { d | outline = True }
                [ h3 [] [ text "A surface can have an outline" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.LegalPaper
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ Surface.surface { d | shadow = Surface.DefaultShadow }
                [ h3 [] [ text "Or it can have a shadow" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.OutdoorPaper
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ Surface.surface { d | shadow = Surface.DeepShadow }
                [ h3 [] [ text "And even a DEEP shadow" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.White
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ Surface.surface
                { d
                    | shadow = Surface.DeepShadow
                    , shape =
                        Surface.Rounded
                }
                [ h3 [] [ text "And we can also have round corners" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        , div
            [ class <| C.backgroundClass C.EfGrey
            , class <| PD.paddingClass BP.Small PD.Medium ""
            ]
            [ Surface.surface
                { d | onClick = Just NoOp }
                [ h3 [] [ text "We get interaction states if we wrap an <a> tag" ]
                , p [] [ text loremIpsum ]
                ]
            ]
        ]
