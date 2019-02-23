module Stories.Input exposing (Model, Msg, init, update, view)

import Components.Input as I
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S


type alias Model =
    { text : String }


type Msg
    = OnInput String


init : Model
init =
    { text = "" }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput str ->
            ( { model | text = str }, Cmd.none )


exampleInput : I.InputType -> List (I.InputProp Msg) -> Html Msg
exampleInput t props =
    I.input t (I.onInput OnInput :: I.verticalMargin S.Medium :: props)


inputTypes : Model -> List (Html Msg)
inputTypes model =
    [ div [] [ I.input I.TextInput [ I.placeholder "type: text" ] ]
    , div []
        [ code [] [ text model.text ] ]
    , div []
        [ exampleInput I.EmailInput [ I.placeholder "type: email" ] ]
    , div []
        [ exampleInput I.NumberInput [ I.placeholder "type: number" ] ]
    , div []
        [ exampleInput I.PasswordInput [ I.placeholder "type: password" ] ]
    , div []
        [ exampleInput I.SearchInput [ I.placeholder "type: search" ] ]
    , div []
        [ exampleInput I.TelInput [ I.placeholder "type: tel" ] ]
    , div []
        [ exampleInput I.UrlInput [ I.placeholder "type: url" ] ]
    ]


inputStates : List (Html Msg)
inputStates =
    [ div []
        [ exampleInput I.TextInput [ I.placeholder "untouched" ] ]
    , div []
        [ exampleInput I.TextInput
            [ I.placeholder "focused", I.focus ]
        ]
    , div []
        [ exampleInput I.TextInput
            [ I.value <| Just "completed", I.completed ]
        ]
    , div []
        [ exampleInput I.TextInput
            [ I.placeholder "disabled", I.disabled ]
        ]
    , div []
        [ exampleInput I.TextInput
            [ I.value <| Just "valid", I.valid ]
        ]
    , div []
        [ exampleInput I.TextInput
            [ I.value <| Just "invalid", I.invalid ]
        ]
    , div []
        [ exampleInput I.TextInput
            [ I.placeholder "loading", I.loading ]
        ]
    ]


rangeSlider : List (Html Msg)
rangeSlider =
    [ div []
        [ exampleInput I.RangeSlider [] ]
    , div []
        [ exampleInput I.RangeSlider
            [ I.placeholder "active", I.active, I.value <| Just "10" ]
        ]
    , div []
        [ exampleInput I.RangeSlider
            [ I.placeholder "focused", I.focus, I.value <| Just "75" ]
        ]
    , div []
        [ exampleInput I.RangeSlider
            [ I.placeholder "disabled", I.disabled ]
        ]
    ]


view : Model -> Html Msg
view model =
    div
        []
        ([ T.h4 [] [ text "This is the input component" ]
         ]
            ++ [ h5 [] [ text "These are the input types" ] ]
            ++ inputTypes model
            ++ [ br [] [], h5 [] [ text "These are the interaction states" ] ]
            ++ inputStates
            ++ [ br [] [], h5 [] [ text "The range slider is just a special input" ] ]
            ++ rangeSlider
        )
