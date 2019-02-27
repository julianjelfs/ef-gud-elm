module Stories.Logo exposing (view)

import Color
import Container as C
import Grid as G
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Logo as L
import Spacing as S
import Surface as Sf
import Typography as T
import Utils exposing (appendIf)


logoContainer : Bool -> String -> String -> Html msg -> Html msg
logoContainer inverse name desc logo =
    div
        ([ class "logobox" ] |> appendIf inverse (class "inverse"))
        [ C.container
            [ C.padding Nothing S.All S.Large ]
            [ logo
            , br [] []
            , T.h5 [] [ text name ]
            , T.para [] [ text desc ]
            ]
        ]


logoView : Bool -> Html msg
logoView inverse =
    let
        m =
            G.margin Nothing S.Bottom S.Medium
    in
    div
        []
        [ G.row
            []
            [ G.col
                [ m ]
                [ logoContainer inverse
                    "Master"
                    "Always use EF + ‘Education First’ when the logo is by itself, unrelated to a product or a tagline that explains what EF stands for."
                    (L.logo ([] |> appendIf inverse L.inverse))
                ]
            , G.col
                [ m ]
                [ logoContainer inverse
                    "Simple"
                    "Removing 'Education First' allows the logo to go smaller, but it shouldn't be used at less than 30px height."
                    (L.logo ([ L.simple ] |> appendIf inverse L.inverse))
                ]
            , G.col
                [ m ]
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
