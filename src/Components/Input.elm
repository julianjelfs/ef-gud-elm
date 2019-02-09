module Components.Input exposing
    ( InputProp
    , InputType(..)
    , bottomMargin
    , completed
    , disabled
    , focus
    , horizontalMargin
    , input
    , invalid
    , leftMargin
    , loading
    , onInput
    , placeholder
    , required
    , rightMargin
    , topMargin
    , type_
    , valid
    , value
    , verticalMargin
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


verticalMargin : S.Spacing -> InputProp msg
verticalMargin =
    WrapperProp << S.verticalMargin


topMargin : S.Spacing -> InputProp msg
topMargin =
    WrapperProp << S.topMargin


rightMargin : S.Spacing -> InputProp msg
rightMargin =
    WrapperProp << S.rightMargin


leftMargin : S.Spacing -> InputProp msg
leftMargin =
    WrapperProp << S.leftMargin


horizontalMargin : S.Spacing -> InputProp msg
horizontalMargin =
    WrapperProp << S.horizontalMargin


bottomMargin : S.Spacing -> InputProp msg
bottomMargin =
    WrapperProp << S.bottomMargin


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


value : Maybe String -> InputProp msg
value =
    FieldProp << Html.Attributes.value << Maybe.withDefault ""


disabled : InputProp msg
disabled =
    (FieldProp << Html.Attributes.disabled) True


type_ : InputType -> InputProp msg
type_ =
    FieldProp << Html.Attributes.type_ << typeToString


placeholder : String -> InputProp msg
placeholder =
    FieldProp << Html.Attributes.placeholder


required : Bool -> InputProp msg
required =
    FieldProp << Html.Attributes.required


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
        ([ class "ef-input-w" ]
            ++ wrapperProps
        )
        [ Html.input
            ([ class "ef-input"
             ]
                ++ fieldProps
            )
            []
        ]
