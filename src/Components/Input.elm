module Components.Input exposing
    ( InputProps
    , InputType(..)
    , InputValidity(..)
    , defaultProps
    , inputComponent
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type InputType
    = EmailInput
    | TextInput
    | NumberInput
    | PasswordInput
    | SearchInput
    | TelInput
    | UrlInput


type InputValidity
    = Valid
    | Invalid
    | Neither


type alias InputProps msg =
    { focus : Bool
    , type_ : InputType
    , placeholder : Maybe String
    , completed : Bool
    , disabled : Bool
    , validity : InputValidity
    , loading : Bool
    , onInput : Maybe (String -> msg)
    }


defaultProps : InputProps msg
defaultProps =
    { focus = False
    , type_ = TextInput
    , placeholder = Nothing
    , completed = False
    , disabled = False
    , validity = Neither
    , loading = False
    , onInput = Nothing
    }


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


inputComponent : InputProps msg -> Html msg
inputComponent props =
    div
        [ class "ef-input-w u-mb-m"
        , classList
            [ ( "-is-valid", props.validity == Valid )
            , ( "-is-invalid", props.validity == Invalid )
            , ( "-is-loading", props.loading )
            ]
        ]
        [ input
            ([ class "ef-input"
             , classList
                [ ( "-focus", props.focus )
                , ( "-completed", props.completed )
                ]
             , type_ <| typeToString props.type_
             , placeholder <| Maybe.withDefault "" props.placeholder
             , disabled (props.disabled || props.loading)
             ]
                |> maybeAppend (Maybe.map onInput props.onInput)
            )
            []
        ]
