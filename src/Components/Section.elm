module Components.Section exposing (backgroundColor, section, size)

import Breakpoint as BP
import Color exposing (ThemeColor, backgroundClass)
import Components.Container as Container
import Html exposing (..)
import Html.Attributes exposing (..)
import Spacing as Sp


type SectionProp msg
    = SectionProp (Attribute msg)


backgroundColor : ThemeColor -> SectionProp msg
backgroundColor =
    SectionProp << class << backgroundClass


size : BP.Breakpoint -> SectionProp msg
size =
    SectionProp << class << BP.sizeClass


section : List (SectionProp msg) -> List (Html msg) -> Html msg
section props children =
    Html.section
        ([ class "ef-section" ] ++ List.map (\(SectionProp a) -> a) props)
        [ Container.container children ]
