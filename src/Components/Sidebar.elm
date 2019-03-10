module Sidebar exposing (SidebarMode(..), sidebar, sidebarItem)

import Css exposing (..)
import Html as Unstyled
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import ProfileInitial as P
import Typography as T


listStyle : Style
listStyle =
    Css.batch
        [ Css.listStyleType none
        , Css.textAlign left
        , Css.display block
        , Css.paddingLeft (px 15)
        , Css.marginTop (px 60)
        ]


userStyle : Style
userStyle =
    Css.batch
        [ Css.marginTop (px 25), Css.textAlign center ]


sidebarItemStyle : Style
sidebarItemStyle =
    Css.batch
        [ Css.height (px 48)
        , Css.marginBottom (px 10)
        , Css.display block
        ]


type SidebarMode
    = Full
    | Collapsed


type SidebarItem
    = SidebarItem { url : String, text : String, active : Bool }


sidebarItem : String -> String -> Bool -> SidebarItem
sidebarItem url text active =
    SidebarItem { url = url, text = text, active = active }


sidebar : String -> SidebarMode -> List SidebarItem -> Unstyled.Html msg
sidebar name mode items =
    toUnstyled <|
        div
            []
            [ P.profileInitial name
            , div [ css [ userStyle ] ] [ Html.Styled.fromUnstyled <| T.h5 [] [ Unstyled.text name ] ]
            , div
                []
                [ ul
                    [ css [ listStyle ] ]
                    (List.map
                        (\(SidebarItem i) ->
                            a
                                [ css [ sidebarItemStyle ], href i.url ]
                                [ li [] [ Html.Styled.fromUnstyled <| T.bodyBook [] [ Unstyled.text i.text ] ] ]
                        )
                        items
                    )
                ]
            ]
