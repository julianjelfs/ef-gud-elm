module Components.Accordion exposing
    ( AccordionProp
    , Model
    , Msg
    , accordion
    , content
    , init
    , item
    , margin
    , padding
    , update
    )

import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


type alias Model =
    { items : Dict Int Bool }


type Msg
    = Toggle Int


init : Model
init =
    { items = Dict.empty }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle index ->
            let
                items =
                    case Dict.member index model.items of
                        True ->
                            Dict.update index (Maybe.map not) model.items

                        False ->
                            Dict.insert index True model.items
            in
            { model | items = items }


type AccordionProp
    = AccordionProp (Attribute Msg)


type AccordionItem
    = AccordionItem (Model -> Int -> Html Msg)


type AccordionContent
    = AccordionContent (Model -> Int -> Html Msg)


padding : List S.Spacing -> AccordionProp
padding =
    AccordionProp << S.padding


margin : List S.Spacing -> AccordionProp
margin =
    AccordionProp << S.margin


collapsed : Model -> Int -> Bool
collapsed model index =
    case Dict.get index model.items of
        Just e ->
            not e

        Nothing ->
            True



{- # this is going to be a problem because we would want the accordion item
   content to deal in Msg types of the parent, not the accordion itself but that
   is going to be difficult
-}


content : List (Html Msg) -> AccordionContent
content children =
    AccordionContent <|
        \model index ->
            let
                c =
                    collapsed model index
            in
            div
                ([ class "ef-accordion__content"
                 , attribute "data-dd" "test-accordion"
                 ]
                    |> appendIf c (style "height" "0px")
                    |> appendIf c (attribute "aria-hidden" "true")
                )
                children


item : String -> AccordionContent -> AccordionItem
item title (AccordionContent child) =
    AccordionItem <|
        \model index ->
            let
                c =
                    collapsed model index
            in
            div
                [ class "ef-accordion__item" ]
                [ h4
                    [ class "ef-h6 ef-accordion__title"
                    , attribute "data-dd-toggle" "test-accordion"
                    , attribute "aria-controls" "test-accordion"
                    , attribute "aria-expanded"
                        (if c then
                            "false"

                         else
                            "true"
                        )
                    , onClick (Toggle index)
                    ]
                    [ text title ]
                , child model index
                ]


accordion : Model -> List AccordionProp -> List AccordionItem -> Html Msg
accordion model props items =
    div
        ([ class "ef-accordion" ] ++ List.map (\(AccordionProp a) -> a) props)
        (List.indexedMap (\i (AccordionItem fn) -> fn model i) items)



{- #
   <div class="ef-accordion u-mb-xxl">
         <div class="ef-accordion__item">
             <h4
                 class="ef-h6 ef-accordion__title"
                 data-dd-toggle="test-accordion"
             >
                 <!-- title -->
             </h4>
             <div class="ef-accordion__content" data-dd="test-accordion">
                 <!-- content -->
             </div>
         </div>

         <div class="ef-accordion__item">
             <h4
                 class="ef-h6 ef-accordion__title"
                 data-dd-toggle="test-accordion-2"
             >
                 <!-- title -->
             </h4>
             <div class="ef-accordion__content" data-dd="test-accordion-2">
                <!-- content -->
             </div>
         </div>

         <div class="ef-accordion__item">
             <h4
                 class="ef-h6 ef-accordion__title"
                 data-dd-toggle="test-accordion-3"
             >
                 <!-- title -->
             </h4>
             <div class="ef-accordion__content" data-dd="test-accordion-3">
                <!-- content -->
             </div>
         </div>

         <div class="ef-accordion__item">
             <h4
                 class="ef-h6 ef-accordion__title"
                 data-dd-toggle="test-accordion-4"
             >
                 Title
             </h4>
             <div class="ef-accordion__content" data-dd="test-accordion-4">
                 <!-- content -->
             </div>
         </div>
     </div>
-}
