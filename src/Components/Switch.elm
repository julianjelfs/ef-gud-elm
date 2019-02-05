module Components.Switch exposing
    ( SwitchProp
    , checked
    , disabled
    , focus
    , invalid
    , large
    , switch
    , valid
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type SwitchProp msg
    = LabelProp (Attribute msg)
    | InputProp (Attribute msg)
    | SpanProp (Attribute msg)


valid : SwitchProp msg
valid =
    wrapLabel "-is-valid"


invalid : SwitchProp msg
invalid =
    wrapLabel "-is-invalid"


focus : SwitchProp msg
focus =
    wrapInput "-focus"


large : SwitchProp msg
large =
    wrapSpan "-large"


checked : SwitchProp msg
checked =
    (InputProp << Html.Attributes.checked) True


disabled : SwitchProp msg
disabled =
    (InputProp << Html.Attributes.disabled) True


wrapInput =
    wrapClass InputProp


wrapLabel =
    wrapClass LabelProp


wrapSpan =
    wrapClass SpanProp


partition : List (SwitchProp msg) -> ( List (Attribute msg), List (Attribute msg), List (Attribute msg) )
partition =
    List.foldr
        (\p ( lps, ips, sps ) ->
            case p of
                LabelProp a ->
                    ( a :: lps, ips, sps )

                InputProp a ->
                    ( lps, a :: ips, sps )

                SpanProp a ->
                    ( lps, ips, a :: sps )
        )
        ( [], [], [] )


switch : List (SwitchProp msg) -> List (Html msg) -> Html msg
switch props content =
    let
        ( labelProps, inputProps, spanProps ) =
            partition props
    in
    label
        ([ class "ef-input-w ef-boolean u-mb-m" ]
            ++ labelProps
        )
        [ input
            ([ type_ "checkbox"
             , class "ef-boolean__input"
             ]
                ++ inputProps
            )
            []
        , span
            ([ class "ef-boolean__element -switch" ] ++ spanProps)
            []
        , span [ class "ef-boolean__label" ] content
        ]
