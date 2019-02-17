module Components.Card exposing
    ( body
    , card
    , imageUrl
    , noshadow
    , outline
    , small
    , teaserCard
    , title
    , vertical
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type CardProp msg
    = CardProp (Attribute msg)


type ImageUrl
    = ImageUrl String


type Title
    = Title String


type Body
    = Body String


vertical : CardProp msg
vertical =
    CardProp (class "-vertical")


small : CardProp msg
small =
    CardProp (class "-small")


outline : CardProp msg
outline =
    CardProp (class "-outline")


noshadow : CardProp msg
noshadow =
    CardProp (class "-no-shadow")


imageUrl : String -> ImageUrl
imageUrl =
    ImageUrl


title : String -> Title
title =
    Title


body : String -> Body
body =
    Body


card : List (CardProp msg) -> ImageUrl -> Title -> Body -> Html msg
card props (ImageUrl u) (Title t) (Body b) =
    div
        ([ class "ef-card--content" ] ++ List.map (\(CardProp a) -> a) props)
        [ a
            [ href "#"
            , class "ef-card--content__img"
            , tabindex -1
            , style "background-image" ("url('" ++ u ++ "')")
            ]
            []
        , div
            [ class "ef-card--content__inner" ]
            [ div
                [ class "ef-card--content__content" ]
                [ h4 [ class "ef-card--content__title" ] [ text t ]
                , div [ class "ef-card--content__text" ]
                    [ p [] [ text b ]
                    , a
                        [ href "#"
                        , class "ef-card--content__link"
                        ]
                        [ text "Link to page" ]
                    ]
                ]
            ]
        ]


teaserCard : List (CardProp msg) -> ImageUrl -> Title -> Body -> Html msg
teaserCard props (ImageUrl u) (Title t) (Body b) =
    a
        ([ class "ef-card--teaser", href "#" ] ++ List.map (\(CardProp a) -> a) props)
        [ img [ class "ef-card--teaser__img", src u ] []
        , div
            [ class "ef-card--teaser__inner" ]
            [ div
                [ class "ef-card--teaser__content" ]
                [ h4 [ class "ef-card--teaser__title" ] [ text t ]
                , div [ class "ef-card--teaser__text" ]
                    [ p [] [ text b ]
                    ]
                ]
            ]
        ]
