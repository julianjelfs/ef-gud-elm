module Stories.ProfileInitial exposing (view)

import Html as Unstyled exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Styled exposing (..)
import ProfileInitial as P
import Typography as T


view : Unstyled.Html msg
view =
    Unstyled.div
        []
        [ T.h4 [] [ Unstyled.text "This is the profile initial component" ]
        , toUnstyled <| P.profileInitial "Julian Jelfs"
        ]
