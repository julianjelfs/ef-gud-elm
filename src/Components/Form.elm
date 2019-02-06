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


formGroup : List (Html msg) -> Html msg
formGroup children =
    div
        []
        children


form : List (Html msg) -> Html msg
form children =
    div
        [ class "ef-form" ]
        children
