module Stories.Container exposing (view)

import Color as Color
import Container as C
import Spacing as S
import Typography as T
import Html exposing (..)
import Html.Attributes exposing (disabled, href, src)
import Html.Events exposing (onClick)


spacedOut : Html msg
spacedOut =
    div
        []
        [ C.container
            [ C.horizontalPad S.ExtraExtraLarge
            , C.verticalPad S.Large
            , C.bgColor Color.HelloPaper
            ]
            [ text "this is a padded container" ]
        ]


withMargin : Html msg
withMargin =
    div
        []
        [ C.container
            [ C.horizontalMargin S.ExtraExtraLarge
            , C.verticalMargin S.Large
            , C.horizontalPad S.Large
            , C.verticalPad S.ExtraExtraLarge
            , C.bgColor Color.EducationPaper
            ]
            [ text "and this one has custom margins as well" ]
        ]


normal : Html msg
normal =
    C.container
        []
        [ p [] [ text "Yes, you're right, this is barely a thing to be honest." ]
        , p [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis convallis eros. Curabitur nulla mi, aliquet vel tempor a, pharetra ac massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis venenatis elit sed tempus rhoncus. Donec a quam dignissim, fermentum neque varius, porttitor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum lacinia venenatis nunc, a vehicula enim dictum eget. Etiam at elit turpis. In at pretium velit, quis blandit metus. Duis cursus orci eget tortor venenatis condimentum. Aenean semper sollicitudin eros sed vulputate. Morbi vehicula ut neque vitae faucibus. Duis non sollicitudin elit." ]
        ]


view : Html msg
view =
    div []
        [ T.h4 [] [ text "This stuff is inside a container" ]
        , normal
        , br [] []
        , T.h4 [] [ text "We can also modify the spacing easily enough" ]
        , spacedOut
        , br [] []
        , withMargin
        ]
