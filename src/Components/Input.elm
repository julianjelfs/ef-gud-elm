module Input exposing
    ( InputProp
    , InputType(..)
    , active
    , completed
    , disabled
    , focus
    , input
    , invalid
    , loading
    , margin
    , onInput
    , padding
    , placeholder
    , required
    , valid
    , value
    )

import Breakpoint as BP
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (..)


padding : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> InputProp msg
padding bp m =
    WrapperProp << S.padding bp m


margin : Maybe BP.Breakpoint -> S.Modifier -> S.Spacing -> InputProp msg
margin bp m =
    WrapperProp << S.margin bp m


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
    Multiple <|
        [ field "-focus"
        , (FieldProp << Html.Attributes.autofocus) True
        ]


active : InputProp msg
active =
    field "-is-active"


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
type_ t =
    let
        p =
            [ FieldProp << Html.Attributes.type_ <| typeToString t ]
    in
    Multiple <|
        case t of
            RangeSlider ->
                field "ef-range" :: p

            _ ->
                field "ef-input" :: p


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
    | RangeSlider


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

        RangeSlider ->
            "range"


type InputProp msg
    = WrapperProp (Attribute msg)
    | FieldProp (Attribute msg)
    | Multiple (List (InputProp msg))


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

                Multiple props ->
                    let
                        ( wps_, fps_ ) =
                            partition props
                    in
                    ( wps ++ wps_, fps ++ fps_ )
        )
        ( [], [] )


input : InputType -> List (InputProp msg) -> Html msg
input t props =
    let
        ( wrapperProps, fieldProps ) =
            partition (type_ t :: props)
    in
    div
        ([ class "ef-input-w" ]
            ++ wrapperProps
        )
        [ Html.input
            fieldProps
            []
        ]
