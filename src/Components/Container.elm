module Components.Container exposing (container)

import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)
import Theme exposing (theme)


container : List (Html msg) -> Html msg
container children =
    div
        [ css
            [ display block
            , padding (px 20)
            , border3 (px 5) solid (rgb 120 120 120)
            , hover
                [ borderColor theme.colors.helloPink
                , borderRadius (px 10)
                ]
            ]
        ]
        children
