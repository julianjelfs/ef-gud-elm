module Components.Stack exposing
    ( ItemAlignment(..)
    , StackItem
    , StackProps
    , VerticalAlignment(..)
    , defaultStackItemProps
    , defaultStackProps
    , stack
    , stackItem
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type alias StackProps =
    { verticalAlignment : VerticalAlignment }


type VerticalAlignment
    = VStart
    | VBetween
    | VAround
    | VEnd


type ItemAlignment
    = INone
    | IStretch
    | IStart
    | IEnd


defaultStackProps : StackProps
defaultStackProps =
    { verticalAlignment = VStart }


defaultStackItemProps : StackItemProps
defaultStackItemProps =
    { alignment = INone }


type alias StackItemProps =
    { alignment : ItemAlignment }


type StackItem msg
    = StackItem (Html msg)


alignToClass : ItemAlignment -> Maybe String
alignToClass va =
    case va of
        INone ->
            Nothing

        IStretch ->
            Just "-stretch"

        IStart ->
            Just "-start"

        IEnd ->
            Just "-end"


vtToClass : VerticalAlignment -> String
vtToClass va =
    case va of
        VStart ->
            "-start"

        VBetween ->
            "-between"

        VAround ->
            "-around"

        VEnd ->
            "-end"


stack : StackProps -> List (StackItem msg) -> Html msg
stack props children =
    div
        [ class "ef-stack"
        , class (vtToClass props.verticalAlignment)
        ]
        (List.map (\(StackItem item) -> item) children)


stackItem : StackItemProps -> List (Html msg) -> StackItem msg
stackItem props children =
    StackItem <|
        div
            ([ class "ef-stack__item" ]
                |> maybeAppend
                    (Maybe.map class (alignToClass props.alignment))
            )
            children
