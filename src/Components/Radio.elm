module Components.Radio exposing
    ( RadioProp
    , checked
    , disabled
    , focus
    , invalid
    , radio
    , valid
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)



-- TODO this component is basically identical to the checkbox component
-- can we have a shared props wrapper and extract the prop generation util
-- functions to a shared util.


type RadioProp msg
    = LabelProp (Attribute msg)
    | InputProp (Attribute msg)


valid : RadioProp msg
valid =
    wrapLabel "-is-valid"


invalid : RadioProp msg
invalid =
    wrapLabel "-is-invalid"


focus : RadioProp msg
focus =
    wrapInput "-focus"


checked : RadioProp msg
checked =
    (InputProp << Html.Attributes.checked) True


disabled : RadioProp msg
disabled =
    (InputProp << Html.Attributes.disabled) True


wrapInput =
    wrapClass InputProp


wrapLabel =
    wrapClass LabelProp


partition : List (RadioProp msg) -> ( List (Attribute msg), List (Attribute msg) )
partition =
    List.foldr
        (\p ( lps, ips ) ->
            case p of
                LabelProp a ->
                    ( a :: lps, ips )

                InputProp a ->
                    ( lps, a :: ips )
        )
        ( [], [] )


radio : List (RadioProp msg) -> List (Html msg) -> Html msg
radio props content =
    let
        ( labelProps, inputProps ) =
            partition props
    in
    label
        ([ class "ef-input-w ef-boolean" ]
            ++ labelProps
        )
        [ input
            ([ type_ "radio"
             , class "ef-boolean__input"
             ]
                ++ inputProps
            )
            []
        , span [ class "ef-boolean__element -radio" ] []
        , span [ class "ef-boolean__label" ] content
        ]
