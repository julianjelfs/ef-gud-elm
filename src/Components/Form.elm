module Components.Form exposing
    ( field
    , fieldset
    , form
    , formGroup
    , legend
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type Legend msg
    = Legend (Html msg)


legend : String -> Legend msg
legend txt =
    Legend <| Html.legend [ class "ef-form-label" ] [ text txt ]


formGroup : List (Html msg) -> Html msg
formGroup children =
    div
        []
        children



-- so what is a form, a fieldset, a formgroup and a field
-- what are their properties, what can their children be
-- what is their state? How do they relate to validation?
-- elm is not good at this. I want a form to, in some sense "contain"
-- fields, but it cannot dictate the layout of the fields
-- Seems like input -> field -> fieldGroup -> form *all* require
-- some concept of validity. Does this mean that they all need
-- state? Does this mean that they all need to have knowledge of
-- their children i.e. a formGroup is valid if all of it's
-- children are valid presumably. Needs a spike I think.


fieldset : Legend msg -> List (Html msg) -> Html msg
fieldset (Legend l) children =
    Html.fieldset
        [ class "ef-form-fieldset u-mb-m" ]
        (l :: children)


field : Maybe String -> List (Html msg) -> Html msg
field label children =
    let
        lbl =
            Maybe.map (\l -> Html.label [ class "ef-form-label" ] [ text l ]) label
                |> Maybe.withDefault (text "")
    in
    div
        []
        (lbl :: children)


form : List (Html msg) -> Html msg
form children =
    div
        [ class "ef-form" ]
        children
