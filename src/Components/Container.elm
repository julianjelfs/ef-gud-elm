module Container exposing
    ( bgColor
    , container
    , margin
    , padding
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


padding : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> ContainerProp msg
padding bp m =
    ContainerProp << S.padding bp m


margin : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> ContainerProp msg
margin bp m =
    ContainerProp << S.margin bp m


container : List (ContainerProp msg) -> List (Html msg) -> Html msg
container props children =
    div
        ([ class "ef-container" ] ++ List.map (\(ContainerProp a) -> a) props)
        children
