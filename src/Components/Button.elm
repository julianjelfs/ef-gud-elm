module Button exposing
    ( ButtonProp
    , active
    , button
    , disabled
    , focus
    , hover
    , loading
    , margin
    , onClick
    , padding
    , primary
    , secondary
    , small
    , square
    , submit
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
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


padding : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> ButtonProp msg
padding bp m =
    ButtonProp << S.padding bp m


margin : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> ButtonProp msg
margin bp m =
    ButtonProp << S.margin bp m


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


disabled : Bool -> ButtonProp msg
disabled =
    ButtonProp << Html.Attributes.disabled


submit : ButtonProp msg
submit =
    ButtonProp <| Html.Attributes.type_ "submit"
