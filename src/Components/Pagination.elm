module Components.Pagination exposing
    ( Size(..)
    , pager
    )

import Components.Icon as I
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type PaginationProp msg
    = PaginationProp (Attribute msg)


type Size
    = Small
    | Large


classToProp : String -> PaginationProp msg
classToProp =
    class >> PaginationProp


pager : Size -> List (PaginationProp msg) -> Html msg
pager size props =
    case size of
        Small ->
            text "Small Pager"

        Large ->
            largePager


largePager : Html msg
largePager =
    div [ class "ef-pagination--lg" ]
        [ button
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs" ]
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
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs" ]
            [ I.icon [ I.iconType I.ChevronRight ] ]
        ]
