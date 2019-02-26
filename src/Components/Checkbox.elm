module Checkbox exposing
    ( CheckboxProp
    , checkbox
    , checked
    , disabled
    , focus
    , invalid
    , valid
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type CheckboxProp msg
    = LabelProp (Attribute msg)
    | InputProp (Attribute msg)


valid : CheckboxProp msg
valid =
    wrapLabel "-is-valid"


invalid : CheckboxProp msg
invalid =
    wrapLabel "-is-invalid"


focus : CheckboxProp msg
focus =
    wrapInput "-focus"


checked : CheckboxProp msg
checked =
    (InputProp << Html.Attributes.checked) True


disabled : CheckboxProp msg
disabled =
    (InputProp << Html.Attributes.disabled) True


wrapInput =
    wrapClass InputProp


wrapLabel =
    wrapClass LabelProp


partition : List (CheckboxProp msg) -> ( List (Attribute msg), List (Attribute msg) )
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


checkbox : List (CheckboxProp msg) -> List (Html msg) -> Html msg
checkbox props content =
    let
        ( labelProps, inputProps ) =
            partition props
    in
    label
        ([ class "ef-input-w ef-boolean" ]
            ++ labelProps
        )
        [ input
            ([ type_ "checkbox"
             , class "ef-boolean__input"
             ]
                ++ inputProps
            )
            []
        , span [ class "ef-boolean__element -checkbox" ] []
        , span [ class "ef-boolean__label" ] content
        ]
