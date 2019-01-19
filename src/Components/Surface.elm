module Components.Surface exposing
    ( SurfaceProps
    , SurfaceShadow(..)
    , SurfaceShape(..)
    , defaultProps
    , surface
    )

import Color exposing (ThemeColor, backgroundClass)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (maybeAppend)


type SurfaceShadow
    = NoShadow
    | DefaultShadow
    | DeepShadow


type SurfaceShape
    = Square
    | Rounded


type alias SurfaceProps msg =
    { outline : Bool
    , shadow : SurfaceShadow
    , shape : SurfaceShape
    , onClick : Maybe msg
    }


defaultProps : SurfaceProps msg
defaultProps =
    { outline = False
    , shadow = NoShadow
    , shape = Square
    , onClick = Nothing
    }


surface : SurfaceProps msg -> List (Html msg) -> Html msg
surface props children =
    let
        element =
            if props.onClick /= Nothing then
                a

            else
                div
    in
    element
        ([ class "ef-surface"
         , classList
            [ ( "-outline", props.outline )
            , ( "-shadow", props.shadow == DefaultShadow )
            , ( "-deep-shadow", props.shadow == DeepShadow )
            , ( "-rounded", props.shape == Rounded )
            ]
         , href ""
         ]
            |> maybeAppend (Maybe.map onClick props.onClick)
        )
        children
