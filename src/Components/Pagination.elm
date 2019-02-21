module Components.Pagination exposing
    ( Size(..)
    , pager
    )

import Components.Icon as I
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias PaginationProps msg =
    { index : Int
    , pages : Int
    , onPage : Int -> msg
    }


type Size
    = Small
    | Large


pager : Size -> PaginationProps msg -> Html msg
pager size props =
    case size of
        Small ->
            text "Small Pager"

        Large ->
            largePager props


largePager : PaginationProps msg -> Html msg
largePager { index, pages, onPage } =
    div [ class "ef-pagination--lg" ]
        [ button
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs"
            , onClick <| onPage 0
            , disabled (index == 0)
            ]
            [ I.icon [ I.iconType I.ChevronLeft ] ]
        , div
            [ class "ef-pagination--lg__content" ]
            [ a
                [ href "#"
                , class "ef-pagination--lg__page"
                ]
                [ text "1" ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page"
                ]
                [ text "2" ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page -is-active"
                ]
                [ text "3" ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page"
                ]
                [ text "4" ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page"
                ]
                [ text "5" ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page -more"
                ]
                [ text "..." ]
            , a
                [ href "#"
                , class "ef-pagination--lg__page"
                ]
                [ text "20" ]
            ]
        , button
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs"
            , onClick <| onPage (pages - 1)
            , disabled (index == (pages - 1))
            ]
            [ I.icon [ I.iconType I.ChevronRight ] ]
        ]
