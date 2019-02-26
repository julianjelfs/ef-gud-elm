module Section exposing (bgColor, section, size)

import Breakpoint as BP
import Color as Color
import Container as Container
import Spacing as Sp
import Html exposing (..)
import Html.Attributes exposing (..)


type SectionProp msg
    = SectionProp (Attribute msg)


bgColor : Color.ThemeColor -> SectionProp msg
bgColor =
    SectionProp << Color.bgColor


size : BP.Breakpoint -> SectionProp msg
size =
    SectionProp << class << BP.sizeClass


section : List (SectionProp msg) -> List (Html msg) -> Html msg
section props children =
    Html.section
        ([ class "ef-section" ] ++ List.map (\(SectionProp a) -> a) props)
        [ Container.container [] children ]
