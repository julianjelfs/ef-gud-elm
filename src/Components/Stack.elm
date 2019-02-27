module Stack exposing
    ( StackItem
    , bgColor
    , item
    , itemBottom
    , itemStretch
    , itemTop
    , spacing
    , stack
    , vAround
    , vBetween
    , vBottom
    , vTop
    )

import Breakpoint as BP
import Color as C
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


type StackProp msg
    = StackProp (Attribute msg)


type StackItemProp msg
    = StackItemProp (Attribute msg)


type StackItem msg
    = StackItem (Html msg)


bgColor : C.ThemeColor -> StackItemProp msg
bgColor =
    StackItemProp << C.bgColor


itemStretch : StackItemProp msg
itemStretch =
    StackItemProp <| class "-stretch"


spacing : Maybe BP.Breakpoint -> S.SpacingType -> S.Modifier -> S.Spacing -> StackItemProp msg
spacing mbp t m sp =
    StackItemProp <| S.spacing mbp t m sp


itemTop : StackItemProp msg
itemTop =
    StackItemProp <| class "-start"


itemBottom : StackItemProp msg
itemBottom =
    StackItemProp <| class "-end"


vTop : StackProp msg
vTop =
    StackProp <| class "-start"


vBetween : StackProp msg
vBetween =
    StackProp <| class "-between"


vAround : StackProp msg
vAround =
    StackProp <| class "-around"


vBottom : StackProp msg
vBottom =
    StackProp <| class "-end"


stack : List (StackProp msg) -> List (StackItem msg) -> Html msg
stack props items =
    div
        ([ class "ef-stack" ] ++ List.map (\(StackProp a) -> a) props)
        (List.map (\(StackItem i) -> i) items)


item : List (StackItemProp msg) -> List (Html msg) -> StackItem msg
item props content =
    StackItem <|
        div
            ([ class "ef-stack__item" ] ++ List.map (\(StackItemProp a) -> a) props)
            content
