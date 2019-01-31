module Components.Button exposing
    ( ButtonProp
    , active
    , button
    , disabled
    , focus
    , hover
    , loading
    , onClick
    , padding
    , primary
    , secondary
    , small
    , square
    , topPad
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Padding as P
import Utils exposing (..)


type ButtonProp msg
    = ButtonProp (Attribute msg)


button : List (ButtonProp msg) -> List (Html msg) -> Html msg
button props content =
    Html.button
        ([ class "ef-button"
         , type_ "button"
         ]
            ++ List.map (\(ButtonProp a) -> a) props
        )
        [ span [ class "ef-button__content" ] content ]


buttonProp : String -> ButtonProp msg
buttonProp =
    wrapClass ButtonProp


topPad : P.Padding -> ButtonProp msg
topPad p =
    P.topPad p buttonProp


padding : List P.Padding -> ButtonProp msg
padding ps =
    P.paddingClasses ps buttonProp


onClick : msg -> ButtonProp msg
onClick msg =
    ButtonProp <| Html.Events.onClick msg


primary : ButtonProp msg
primary =
    buttonProp "-primary"


secondary : ButtonProp msg
secondary =
    buttonProp "-secondary"


active : ButtonProp msg
active =
    buttonProp "-active"


hover : ButtonProp msg
hover =
    buttonProp "-hover"


focus : ButtonProp msg
focus =
    buttonProp "-focus"


loading : ButtonProp msg
loading =
    buttonProp "-is-loading"


square : ButtonProp msg
square =
    buttonProp "-square -filled"


small : ButtonProp msg
small =
    buttonProp "-small"


disabled : ButtonProp msg
disabled =
    ButtonProp <| Html.Attributes.disabled True
