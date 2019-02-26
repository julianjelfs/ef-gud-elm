module Stories.Fullbleed exposing (view)

import Container as C
import Fullbleed as F
import Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


default : Html msg
default =
    div
        [ style "margin-bottom" "30px" ]
        [ F.fullbleed
            "https://images.unsplash.com/photo-1537404959425-8e82be067eb3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e2a19191c511471ed5f1b75523a24ebd&auto=format&fit=crop&w=2550&q=80"
            []
            []
        ]


gradient : Html msg
gradient =
    div
        [ style "margin-bottom" "30px" ]
        [ F.fullbleed
            "https://images.unsplash.com/photo-1537404959425-8e82be067eb3?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=e2a19191c511471ed5f1b75523a24ebd&auto=format&fit=crop&w=2550&q=80"
            [ F.gradient ]
            []
        ]


fullheight : Html msg
fullheight =
    div
        [ style "margin-bottom" "30px" ]
        [ F.fullbleed
            "https://images.unsplash.com/photo-1516979187457-637abb4f9353?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c4b5fcc53abd6158286dc86a9be4bee&auto=format&fit=crop&w=2700&q=80"
            [ F.fullHeight ]
            []
        ]


view : Html msg
view =
    div
        []
        [ T.h4 [ T.light ] [ text "The fullbleed component is used to build full-width hero images. By default the images take up 60% of the viewport height" ]
        , T.h4 [] [ text "Simple (default)" ]
        , default
        , T.h4 [] [ text "With gradient (which doesn't seem to do anything)" ]
        , gradient
        , T.h4 [] [ text "Full height" ]
        , fullheight
        ]
