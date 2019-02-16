module Components.Radio exposing
    ( RadioProp
    , checked
    , disabled
    , focus
    , invalid
    , namedRadio
    , onInput
    , radio
    , radioGroup
    , valid
    )

import Components.Generic as G
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)



-- TODO this component is basically identical to the checkbox component
-- can we have a shared props wrapper and extract the prop generation util
-- functions to a shared util.
-- the following is an example of using phantom types. We would still need
-- to add each property that is shared to each component that uses it but
-- it might be worth it. Also need to figure out how to mix shared and
-- non shared properties without poluting the Generic.ComponentProp
-- I suppose we could just implement *all* props as a ComponentProp and then
-- just expose the ones that each component supports and then never export
-- the Generic module so that it cannot be used directly.


type Radio
    = Radio


someProperty : G.ComponentProp Radio msg
someProperty =
    G.someProperty


someComponent : List (G.ComponentProp Radio msg) -> Html msg
someComponent props =
    div
        (List.map G.extractAttribute props)
        []


type RadioProp msg
    = LabelProp (Attribute msg)
    | InputProp (Attribute msg)


onInput : (String -> msg) -> RadioProp msg
onInput =
    InputProp << Html.Events.onInput


valid : RadioProp msg
valid =
    wrapLabel "-is-valid"


invalid : RadioProp msg
invalid =
    wrapLabel "-is-invalid"


focus : RadioProp msg
focus =
    wrapInput "-focus"


name : String -> RadioProp msg
name =
    InputProp << Html.Attributes.name


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



-- to ensure type safety for radio groups *and* ensure that each radio in the
-- group has the *same* name property we wrap a function that expects the group
-- name and returns a radio. This is actually quite cool.


type NamedRadio msg
    = NamedRadio (String -> Html msg)


namedRadio : List (RadioProp msg) -> List (Html msg) -> NamedRadio msg
namedRadio props content =
    NamedRadio (\n -> radio (name n :: props) content)


radioGroup : String -> List (NamedRadio msg) -> Html msg
radioGroup n radios =
    div
        [ class "ef-form-group -inline" ]
        (List.map (\(NamedRadio r) -> r n) radios)
