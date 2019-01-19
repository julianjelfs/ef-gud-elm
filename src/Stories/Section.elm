module Stories.Section exposing (Model, Msg, init, update, view)

import Breakpoint as BP
import Color exposing (ThemeColor(..))
import Components.Section as Section
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
    div
        []
        [ Section.sectionComponent { backgroundColor = HelloPaper, size = BP.Small }
            [ h3 [] [ text "This stuff is inside a SMALL section" ]
            , p [] [ text loremIpsum ]
            ]
        , Section.sectionComponent
            { backgroundColor = OutdoorPaper
            , size =
                BP.Medium
            }
            [ h3 [] [ text "This stuff is inside a MEDIUM section" ]
            , p [] [ text loremIpsum ]
            ]
        , Section.sectionComponent
            { backgroundColor = LegalPaper
            , size =
                BP.Large
            }
            [ h3 [] [ text "This stuff is inside a LARGE section" ]
            , p [] [ text loremIpsum ]
            ]
        , Section.sectionComponent
            { backgroundColor = EducationPaper
            , size =
                BP.ExtraLarge
            }
            [ h3 [] [ text "This stuff is inside a EXTRA LARGE section" ]
            , p [] [ text loremIpsum ]
            ]
        ]
