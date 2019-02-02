module Components.Input exposing
    ( InputProp
    , InputType(..)
    , completed
    , disabled
    , focus
    , input
    , invalid
    , loading
    , onInput
    , placeholder
    , type_
    , valid
    , value
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


valid : InputProp msg
valid =
    wrapper "-is-valid"


invalid : InputProp msg
invalid =
    wrapper "-is-invalid"


loading : InputProp msg
loading =
    wrapper "-is-loading"


focus : InputProp msg
focus =
    field "-focus"


completed : InputProp msg
completed =
    field "-completed"


value : String -> InputProp msg
value =
    FieldProp << Html.Attributes.value


disabled : InputProp msg
disabled =
    (FieldProp << Html.Attributes.disabled) True


type_ : InputType -> InputProp msg
type_ =
    FieldProp << Html.Attributes.type_ << typeToString


placeholder : String -> InputProp msg
placeholder =
    FieldProp << Html.Attributes.placeholder


onInput : (String -> msg) -> InputProp msg
onInput =
    FieldProp << Html.Events.onInput


type InputType
    = EmailInput
    | TextInput
    | NumberInput
    | PasswordInput
    | SearchInput
    | TelInput
    | UrlInput


typeToString : InputType -> String
typeToString t =
    case t of
        EmailInput ->
            "email"

        TextInput ->
            "text"

        NumberInput ->
            "number"

        PasswordInput ->
            "password"

        SearchInput ->
            "search"

        TelInput ->
            "tel"

        UrlInput ->
            "url"


type InputProp msg
    = WrapperProp (Attribute msg)
    | FieldProp (Attribute msg)


wrapper =
    wrapClass WrapperProp


field =
    wrapClass FieldProp


partition : List (InputProp msg) -> ( List (Attribute msg), List (Attribute msg) )
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


input : List (InputProp msg) -> Html msg
input props =
    let
        ( wrapperProps, fieldProps ) =
            partition props
    in
    div
        ([ class "ef-input-w u-mb-m" ]
            ++ wrapperProps
        )
        [ Html.input
            ([ class "ef-input"
             ]
                ++ fieldProps
            )
            []
        ]
