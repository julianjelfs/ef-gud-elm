module Stories.Logo exposing (view)

import Color
import Components.Container as C
import Components.Grid as G
import Components.Logo as L
import Components.Surface as Sf
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (appendIf)


logoContainer : Bool -> String -> String -> Html msg -> Html msg
logoContainer inverse name desc logo =
    div
        ([ class "logobox" ] |> appendIf inverse (class "inverse"))
        [ C.container
            [ C.padding [ S.Large ] ]
            [ logo
            , br [] []
            , T.h5 [] [ text name ]
            , T.para [] [ text desc ]
            ]
        ]


logoView : Bool -> Html msg
logoView inverse =
    div
        []
        [ G.row
            [ G.bottomMargin S.Medium ]
            [ G.col
                []
                [ logoContainer inverse
                    "Master"
                    "Always use EF + ‘Education First’ when the logo is by itself, unrelated to a product or a tagline that explains what EF stands for."
                    (L.logo ([] |> appendIf inverse L.inverse))
                ]
            , G.col
                []
                [ logoContainer inverse
                    "Simple"
                    "Removing 'Education First' allows the logo to go smaller, but it shouldn't be used at less than 30px height."
                    (L.logo ([ L.simple ] |> appendIf inverse L.inverse))
                ]
            , G.col
                []
                [ logoContainer inverse
                    "Small"
                    "At less than 50px, e.g. for social media avatars and favicons, the logo becomes fuzzy and unclear. In these cases, the EF block logo can be used. It shouldn't be used any larger than 49px."
                    (L.logo ([ L.small ] |> appendIf inverse L.inverse))
                ]
            ]
        ]


view : Html msg
view =
    div
        []
        [ T.h4 [ T.light ] [ text "The EF logo in three context dependent flavours" ]
        , T.h3 [] [ text "Regular" ]
        , logoView False
        , T.h3 [] [ text "Inverse" ]
        , logoView True
        ]
