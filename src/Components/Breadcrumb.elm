module Breadcrumb exposing (active, breadcrumbs, crumb, href, onClick)

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type BreadcrumbProp msg
    = BreadcrumbProp (Attribute msg)


type Breadcrumb msg
    = Breadcrumb (List (BreadcrumbProp msg)) String


href : String -> BreadcrumbProp msg
href =
    Html.Attributes.href >> BreadcrumbProp


onClick : msg -> BreadcrumbProp msg
onClick =
    Html.Events.onClick >> BreadcrumbProp


active : BreadcrumbProp msg
active =
    BreadcrumbProp (class "-is-active")


crumb : List (BreadcrumbProp msg) -> String -> Breadcrumb msg
crumb =
    Breadcrumb


breadcrumbs : List (Breadcrumb msg) -> Html msg
breadcrumbs crumbs =
    ul
        [ class "ef-breadcrumbs"
        , attribute "itemscope" "true"
        , attribute "itemtype" "http://schema.org/BreadcrumbList"
        ]
        (List.map renderCrumb crumbs)


renderCrumb : Breadcrumb msg -> Html msg
renderCrumb (Breadcrumb props name) =
    li
        [ class "ef-breadcrumbs__item"
        , attribute "itemprop" "itemListElement"
        , attribute "itemscope" "true"
        , attribute "itemtype" "http://schema.org/ListItem"
        ]
        [ a
            ([ class "ef-breadcrumbs__link" ] ++ List.map (\(BreadcrumbProp a) -> a) props)
            [ text name ]
        ]



-- <ul class="ef-breadcrumbs" itemscope itemtype="http://schema.org/BreadcrumbList">
--     <li class="ef-breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
--         <a class="ef-breadcrumbs__link" href="#" itemprop="item">Home</a>
--     </li>
--     <li class="ef-breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
--         <a class="ef-breadcrumbs__link" href="#" itemprop="item">Host a student</a>
--     </li>
--     <li class="ef-breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
--         <span class="ef-breadcrumbs__link -is-active" itemprop="item">Philadelphia</span>
--     </li>
-- </ul>
