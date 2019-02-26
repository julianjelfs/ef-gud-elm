module Select exposing
    ( Option(..)
    , SelectProp
    , completed
    , disabled
    , focus
    , invalid
    , loading
    , onSelect
    , select
    , valid
    , value
    )

import Utils exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Json.Decode.Extra as Decode


valid : SelectProp msg
valid =
    wrapper "-is-valid"


invalid : SelectProp msg
invalid =
    wrapper "-is-invalid"


loading : SelectProp msg
loading =
    Multiple <|
        [ wrapper "-is-loading"
        , disabled
        ]


disabled : SelectProp msg
disabled =
    Multiple <|
        [ wrapper "-is-disabled"
        , FieldProp <| Html.Attributes.disabled True
        ]


focus : SelectProp msg
focus =
    field "-focus"


completed : SelectProp msg
completed =
    field "-completed"


value : String -> SelectProp msg
value =
    FieldProp << Html.Attributes.value


onSelect : (Maybe ( String, String ) -> msg) -> SelectProp msg
onSelect handler =
    FieldProp <| on "change" (Decode.map handler optionParser)


optionParser : Decode.Decoder (Maybe ( String, String ))
optionParser =
    Decode.map List.head
        (Decode.at [ "target", "selectedOptions" ] (Decode.collection optionDecoder))


optionDecoder : Decode.Decoder ( String, String )
optionDecoder =
    Decode.map2 Tuple.pair
        (Decode.field "text" Decode.string)
        (Decode.field "value" Decode.string)


type SelectProp msg
    = WrapperProp (Attribute msg)
    | FieldProp (Attribute msg)
    | Multiple (List (SelectProp msg))


wrapper =
    wrapClass WrapperProp


field =
    wrapClass FieldProp


partition : List (SelectProp msg) -> ( List (Attribute msg), List (Attribute msg) )
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


select : List (SelectProp msg) -> List Option -> Html msg
select props options =
    let
        ( wrapperProps, fieldProps ) =
            partition props
    in
    div
        ([ class "ef-input-w -select u-mb-m" ] ++ wrapperProps)
        [ Html.select
            ([ class "ef-input" ] ++ fieldProps)
            (List.map option options)
        ]


option : Option -> Html msg
option o =
    case o of
        Option key val ->
            Html.option
                [ Html.Attributes.value key ]
                [ text val ]

        PlaceholderOption val ->
            Html.option
                [ Html.Attributes.value ""
                , selected True
                , Html.Attributes.disabled True
                , hidden True
                ]
                [ text val ]


type Option
    = Option String String
    | PlaceholderOption String
