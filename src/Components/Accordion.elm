module Components.Accordion exposing
    ( AccordionProp
    , accordion
    , content
    , item
    , margin
    , padding
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


type AccordionProp msg
    = AccordionProp (Attribute msg)


type AccordionItem msg
    = AccordionItem (Html msg)


type AccordionContent msg
    = AccordionContent (Html msg)


padding : List S.Spacing -> AccordionProp msg
padding =
    AccordionProp << S.padding


margin : List S.Spacing -> AccordionProp msg
margin =
    AccordionProp << S.margin


content : List (Html msg) -> AccordionContent msg
content children =
    AccordionContent <|
        div
            [ class "ef-accordion__content"
            , attribute "data-dd" "test-accordion"
            ]
            children


item : String -> AccordionContent msg -> AccordionItem msg
item title (AccordionContent child) =
    AccordionItem <|
        div
            [ class "ef-accordion__item" ]
            [ h4
                [ class "ef-h6 ef-accordion__title"
                , attribute "data-dd-toggle" "test-accordion"
                , attribute "aria-expanded" "false"
                , attribute "aria-controls" "test-accordion"
                ]
                [ text title ]
            , child
            ]


accordion : List (AccordionProp msg) -> List (AccordionItem msg) -> Html msg
accordion props items =
    div
        ([ class "ef-accordion" ] ++ List.map (\(AccordionProp a) -> a) props)
        (List.map (\(AccordionItem i) -> i) items)



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
