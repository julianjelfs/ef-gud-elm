module Pagination exposing
    ( Size(..)
    , pager
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Icon as I
import Utils exposing (..)


type alias PaginationProps msg =
    { page : Int
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
            smallPager props

        Large ->
            largePager props


smallPager : PaginationProps msg -> Html msg
smallPager { page, pages, onPage } =
    div
        [ class "ef-pagination--sm" ]
        [ button
            [ onClick (onPage 1)
            , disabled (page == 1)
            , class "ef-pagination--sm__bnt ef-button -secondary -filled -square u-mr-xs"
            ]
            [ I.icon [ I.iconType I.ChevronDoubleLeft ] ]
        , button
            [ onClick (onPage (page - 1))
            , disabled (page == 1)
            , class "ef-pagination--sm__bnt ef-button -secondary -filled -square"
            ]
            [ I.icon [ I.iconType I.ChevronLeft ] ]
        , div
            [ class "ef-pagination--sm__content" ]
            [ text "Page "
            , strong [] [ text <| String.fromInt page ]
            , text " of "
            , strong [] [ text <| String.fromInt pages ]
            ]
        , button
            [ onClick (onPage (page + 1))
            , disabled (page == pages)
            , class "ef-pagination--sm__bnt ef-button -secondary -filled -square u-mr-xs"
            ]
            [ I.icon [ I.iconType I.ChevronRight ] ]
        , button
            [ onClick (onPage pages)
            , disabled (page == pages)
            , class "ef-pagination--sm__bnt ef-button -secondary -filled -square"
            ]
            [ I.icon [ I.iconType I.ChevronDoubleRight ] ]
        ]


largePager : PaginationProps msg -> Html msg
largePager { page, pages, onPage } =
    let
        moreBtn =
            a
                [ href "#"
                , class "ef-pagination--lg__page -more"
                ]
                [ text ".." ]

        pageBtn n =
            a
                [ href "#"
                , class "ef-pagination--lg__page"
                , onClick (onPage n)
                ]
                [ text <| String.fromInt n ]

        start =
            (if page >= 4 then
                [ pageBtn 1 ]

             else
                []
            )
                ++ (if page > 4 then
                        [ moreBtn ]

                    else
                        []
                   )

        end =
            (if page < pages - 3 then
                [ moreBtn ]

             else
                []
            )
                ++ (if page < pages - 2 then
                        [ pageBtn pages ]

                    else
                        []
                   )

        before =
            [ page - 2, page - 1 ]
                |> List.filter (\n -> n > 0)
                |> List.map pageBtn

        after =
            [ page + 1, page + 2 ]
                |> List.filter (\n -> n <= pages)
                |> List.map pageBtn
    in
    div [ class "ef-pagination--lg" ]
        [ button
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs"
            , onClick <| onPage 1
            , disabled (page == 1)
            ]
            [ I.icon [ I.iconType I.ChevronLeft ] ]
        , div
            [ class "ef-pagination--lg__content" ]
            (start
                ++ before
                ++ [ a
                        [ href "#"
                        , class "ef-pagination--lg__page -is-active"
                        ]
                        [ text <| String.fromInt page ]
                   ]
                ++ after
                ++ end
            )
        , button
            [ class "ef-pagination--lg__btn ef-button -secondary -filled -square u-mr-xs"
            , onClick <| onPage pages
            , disabled (page == pages)
            ]
            [ I.icon [ I.iconType I.ChevronRight ] ]
        ]
