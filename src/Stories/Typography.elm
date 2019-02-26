module Stories.Typography exposing (view)

import Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


h1 : Html msg
h1 =
    T.h1 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


h2 : Html msg
h2 =
    T.h2 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


h3 : Html msg
h3 =
    T.h3 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


h4 : Html msg
h4 =
    T.h4 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


h5 : Html msg
h5 =
    T.h5 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


h6 : Html msg
h6 =
    T.h6 [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


subtitle : Html msg
subtitle =
    T.subtitle [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


body : Html msg
body =
    T.body [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


bodyBook : Html msg
bodyBook =
    T.bodyBook [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


para : Html msg
para =
    T.para [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


paraBook : Html msg
paraBook =
    T.paraBook [] [ text "Lorem ipsum dolor sit amet, consetetur" ]


fontTweaks : Html msg
fontTweaks =
    div
        []
        [ T.h5 [] [ text "All of the typography components can by further modified as follows" ]
        , T.h5 [] [ text "We can apply lots of different weights ..." ]
        , T.para [ T.light ] [ text "The first one is LIGHT" ]
        , T.para [ T.book ] [ text "The second one is BOOK whatever that means" ]
        , T.para [ T.medium ] [ text "The third one is MEDIUM which makes more sense" ]
        , T.para [ T.bold ] [ text "The fourth one is BOLD" ]
        , T.para [ T.black ] [ text "And the final option is BLACK" ]
        , T.h5 [] [ text "And we can make *all* of these italic as well" ]
        , T.para [ T.italic, T.light ] [ text "The first one is LIGHT" ]
        , T.para [ T.italic, T.book ] [ text "The second one is BOOK whatever that means" ]
        , T.para [ T.italic, T.medium ] [ text "The third one is MEDIUM which makes more sense" ]
        , T.para [ T.italic, T.bold ] [ text "The fourth one is BOLD" ]
        , T.para [ T.italic, T.black ] [ text "And the final option is BLACK" ]
        ]


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "These are the typography elements" ]
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , subtitle
        , body
        , bodyBook
        , para
        , paraBook
        , hr [] []
        , fontTweaks
        ]
