module Components.Radio exposing
    ( RadioProp
    , checked
    , disabled
    , focus
    , invalid
    , namedRadio
    , radio
    , radioGroup
    , valid
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)



-- TODO this component is basically identical to the checkbox component
-- can we have a shared props wrapper and extract the prop generation util
-- functions to a shared util.
-- perhaps we can use phantom types here
-- type InputProp a msg = InputProp msg
-- disabled : InputProp Radio msg = Input.disabled
-- where Input.disabed : ???
-- radio : List (InputProp Radio msg) -> Html msg
-- we restrict the call to radio to only Radio specific InputProps by
-- realising the phantom type. Hmmm - better?


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
