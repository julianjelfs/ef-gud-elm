module Surface exposing
    ( SurfaceProp
    , deepShadow
    , href
    , margin
    , onClick
    , outline
    , padding
    , rounded
    , shadow
    , surface
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (maybeAppend, wrapClass)


padding : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> SurfaceProp msg
padding bp m =
    SurfaceProp << S.padding bp m


margin : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> SurfaceProp msg
margin bp m =
    SurfaceProp << S.margin bp m


surfaceProp : String -> SurfaceProp msg
surfaceProp =
    wrapClass SurfaceProp


outline : SurfaceProp msg
outline =
    surfaceProp "-outline"


shadow : SurfaceProp msg
shadow =
    surfaceProp "-shadow"


deepShadow : SurfaceProp msg
deepShadow =
    surfaceProp "-deep-shadow"


rounded : SurfaceProp msg
rounded =
    surfaceProp "-rounded"


onClick : msg -> SurfaceProp msg
onClick =
    SurfaceProp << Html.Events.onClick


href : String -> SurfaceProp msg
href =
    SurfaceProp << Html.Attributes.href


type SurfaceProp msg
    = SurfaceProp (Attribute msg)


surface : Bool -> List (SurfaceProp msg) -> List (Html msg) -> Html msg
surface interactive props children =
    let
        element =
            if interactive then
                a

            else
                div
    in
    element
        ([ class "ef-surface" ]
            ++ List.map (\(SurfaceProp a) -> a) props
        )
        children
