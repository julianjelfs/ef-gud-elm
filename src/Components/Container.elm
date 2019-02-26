module Container exposing
    ( bgColor
    , bottomMargin
    , bottomPad
    , container
    , horizontalMargin
    , horizontalPad
    , leftMargin
    , leftPad
    , margin
    , padding
    , rightMargin
    , rightPad
    , topMargin
    , topPad
    , verticalMargin
    , verticalPad
    )

import Breakpoint as BP
import Color as C
import Html exposing (..)
import Html.Attributes exposing (..)
import Spacing as S


type ContainerProp msg
    = ContainerProp (Attribute msg)


bgColor : C.ThemeColor -> ContainerProp msg
bgColor =
    ContainerProp << C.bgColor


padding : List S.Spacing -> ContainerProp msg
padding =
    ContainerProp << S.padding


margin : List S.Spacing -> ContainerProp msg
margin =
    ContainerProp << S.margin


spacingUtil : Maybe BP.Breakpoint -> S.SpacingType -> String -> S.Spacing -> ContainerProp msg
spacingUtil mbp t m sp =
    ContainerProp <| S.spacingUtil mbp t m sp


verticalPad : S.Spacing -> ContainerProp msg
verticalPad =
    ContainerProp << S.verticalPad


verticalMargin : S.Spacing -> ContainerProp msg
verticalMargin =
    ContainerProp << S.verticalMargin


topPad : S.Spacing -> ContainerProp msg
topPad =
    ContainerProp << S.topPad


topMargin : S.Spacing -> ContainerProp msg
topMargin =
    ContainerProp << S.topMargin


rightPad : S.Spacing -> ContainerProp msg
rightPad =
    ContainerProp << S.rightPad


rightMargin : S.Spacing -> ContainerProp msg
rightMargin =
    ContainerProp << S.rightMargin


leftPad : S.Spacing -> ContainerProp msg
leftPad =
    ContainerProp << S.leftPad


leftMargin : S.Spacing -> ContainerProp msg
leftMargin =
    ContainerProp << S.leftMargin


horizontalPad : S.Spacing -> ContainerProp msg
horizontalPad =
    ContainerProp << S.horizontalPad


horizontalMargin : S.Spacing -> ContainerProp msg
horizontalMargin =
    ContainerProp << S.horizontalMargin


bottomMargin : S.Spacing -> ContainerProp msg
bottomMargin =
    ContainerProp << S.bottomMargin


bottomPad : S.Spacing -> ContainerProp msg
bottomPad =
    ContainerProp << S.bottomPad


container : List (ContainerProp msg) -> List (Html msg) -> Html msg
container props children =
    div
        ([ class "ef-container" ] ++ List.map (\(ContainerProp a) -> a) props)
        children
