module Components.Select exposing
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

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


valid : SelectProp msg
valid =
    wrapper "-is-valid"


invalid : SelectProp msg
invalid =
    wrapper "-is-invalid"


loading : SelectProp msg
loading =
    wrapper "-is-loading"


focus : SelectProp msg
focus =
    field "-focus"


completed : SelectProp msg
completed =
    field "-completed"


value : String -> SelectProp msg
value =
    SelectProp << FieldProp << Html.Attributes.value


disabled : SelectProp msg
disabled =
    (SelectProp << FieldProp << Html.Attributes.disabled) True


onSelect : (String -> msg) -> SelectProp msg
onSelect =
    SelectProp << FieldProp << Html.Events.onInput


type ControlProp msg
    = WrapperProp (Attribute msg)
    | FieldProp (Attribute msg)


type SelectProp msg
    = SelectProp (ControlProp msg)


wrapper =
    wrapClass (SelectProp << WrapperProp)


field =
    wrapClass (SelectProp << FieldProp)


partition : List (SelectProp msg) -> ( List (Attribute msg), List (Attribute msg) )
partition =
    List.foldr
        (\(SelectProp p) ( wps, fps ) ->
            case p of
                WrapperProp a ->
                    ( a :: wps, fps )

                FieldProp a ->
                    ( wps, a :: fps )
        )
        ( [], [] )


select : List (SelectProp msg) -> List Option -> Html msg
select props options =
    div
        [ class "ef-input-w -select u-mb-m" ]
        [ Html.select
            [ class "ef-input"
            , required True
            ]
            (List.map option options)
        ]


option : Option -> Html msg
option (Option key val) =
    Html.option
        [ Html.Attributes.value key ]
        [ text val ]


type Option
    = Option String String



-- <div class="ef-input-w -select u-mb-m">
--     <select class="ef-input" required>
--         <option value="" selected disabled hidden>untouched with 'placeholder'</option>
--         <option value="b">Two</option>
--         <option value="c">Three</option>
--         <option value="d">Four</option>
--     </select>
-- </div>
-- div
--     ([ class "ef-input-w u-mb-m" ]
--         ++ wrapperProps
--     )
--     [ Html.input
--         ([ class "ef-input"
--          ]
--             ++ fieldProps
--         )
--         []
--     ]
