module Stories.ProfileInitial exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import ProfileInitial as P
import Typography as T


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "This is the profile initial component" ]
        , P.profileInitial "JJ"
        ]
