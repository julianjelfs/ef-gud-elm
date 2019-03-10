module Stories.Sidebar exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Sidebar as S
import Typography as T


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "This is the sidebar component" ]
        , S.sidebar "Julian Jelfs"
            S.Full
            [ S.sidebarItem "/" "Home" True
            , S.sidebarItem "/calendar" "Calendar" False
            , S.sidebarItem "/settings" "Settings" False
            ]
        ]
