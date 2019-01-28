module Components.Section exposing (sectionComponent)

import Breakpoint as BP
import Color exposing (ThemeColor, backgroundClass)
import Components.Container as Container
import Html exposing (..)
import Html.Attributes exposing (..)
import Padding exposing (Padding)


type alias SectionProps =
    { backgroundColor : ThemeColor
    , size : BP.Breakpoint
    }


sectionComponent : SectionProps -> List (Html msg) -> Html msg
sectionComponent props children =
    section
        [ class "ef-section"
        , class <| BP.sizeClass props.size
        , class <| backgroundClass props.backgroundColor
        ]
        [ Container.container children ]
