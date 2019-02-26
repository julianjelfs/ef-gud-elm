module TextArea exposing
    ( TextAreaProp
    , completed
    , disabled
    , focus
    , invalid
    , loading
    , onInput
    , placeholder
    , textarea
    , valid
    , value
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


valid : TextAreaProp msg
valid =
    wrapper "-is-valid"


invalid : TextAreaProp msg
invalid =
    wrapper "-is-invalid"


loading : TextAreaProp msg
loading =
    wrapper "-is-loading"


focus : TextAreaProp msg
focus =
    field "-focus"


completed : TextAreaProp msg
completed =
    field "-completed"


value : String -> TextAreaProp msg
value =
    FieldProp << Html.Attributes.value


disabled : TextAreaProp msg
disabled =
    (FieldProp << Html.Attributes.disabled) True


placeholder : String -> TextAreaProp msg
placeholder =
    FieldProp << Html.Attributes.placeholder


onInput : (String -> msg) -> TextAreaProp msg
onInput =
    FieldProp << Html.Events.onInput


type TextAreaProp msg
    = WrapperProp (Attribute msg)
    | FieldProp (Attribute msg)


wrapper =
    wrapClass WrapperProp


field =
    wrapClass FieldProp


partition : List (TextAreaProp msg) -> ( List (Attribute msg), List (Attribute msg) )
partition =
    List.foldr
        (\p ( wps, fps ) ->
            case p of
                WrapperProp a ->
                    ( a :: wps, fps )

                FieldProp a ->
                    ( wps, a :: fps )
        )
        ( [], [] )


textarea : List (TextAreaProp msg) -> Html msg
textarea props =
    let
        ( wrapperProps, fieldProps ) =
            partition props
    in
    div
        ([ class "ef-input-w -textarea u-mb-m" ]
            ++ wrapperProps
        )
        [ Html.textarea
            ([ class "ef-input"
             ]
                ++ fieldProps
            )
            []
        ]
