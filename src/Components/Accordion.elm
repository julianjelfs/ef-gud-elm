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

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


type alias Model =
    { index : Int }


type Msg
    = Toggle Int


init : Model
init =
    { index = 0 }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle index ->
            let
                _ =
                    Debug.log "Expanding" index
            in
            { model | index = index }


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



{- # this is going to be a problem because we would want the accordion item
   content to deal in Msg types of the parent, not the accordion itself but that
   is going to be difficult
-}


content : List (Html Msg) -> AccordionContent
content children =
    AccordionContent <|
        \model index ->
            div
                [ class "ef-accordion__content"
                , attribute "data-dd" "test-accordion"
                , attribute "aria-hidden" "true"
                , style "height" "0px"
                ]
                children


item : String -> AccordionContent -> AccordionItem
item title (AccordionContent child) =
    AccordionItem <|
        \model index ->
            div
                [ class "ef-accordion__item" ]
                [ h4
                    [ class "ef-h6 ef-accordion__title"
                    , attribute "data-dd-toggle" "test-accordion"
                    , attribute "aria-expanded" "false"
                    , attribute "aria-controls" "test-accordion"
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
