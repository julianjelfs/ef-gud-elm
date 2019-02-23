module Stories.Select exposing (Model, Msg, init, update, view)

import Components.Select as S
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { selected : Maybe ( String, String ) }


type Msg
    = OnSelect (Maybe ( String, String ))


init : Model
init =
    { selected = Nothing }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnSelect s ->
            ( { model | selected = s }, Cmd.none )


options : List S.Option
options =
    [ S.Option "a" "One"
    , S.Option "b" "Two"
    , S.Option "c" "Three"
    , S.Option "d" "Four"
    , S.Option "e" "Five"
    ]


simpleSelect : Model -> Html Msg
simpleSelect model =
    div
        []
        [ p [] [ text "In its simple state" ]
        , S.select [ S.onSelect OnSelect ] options
        , p
            []
            [ text <|
                "The selected item is: "
                    ++ Maybe.withDefault "unselected"
                        (Maybe.map (\( t, v ) -> "Text: " ++ t ++ ", Value: " ++ v)
                            model.selected
                        )
            ]
        , br [] []
        ]


selectStates : Html Msg
selectStates =
    div
        []
        [ p [] [ text "In all its other states" ]
        , S.select [] (S.PlaceholderOption "untouched with 'placeholder'" :: options)
        , S.select [ S.focus ] (S.Option "z" "focused" :: options)
        , S.select [ S.completed ] (S.Option "z" "completed" :: options)
        , S.select [ S.disabled ] (S.Option "z" "disabled" :: options)
        , S.select [ S.valid ] (S.Option "z" "valid" :: options)
        , S.select [ S.invalid ] (S.Option "z" "invalid" :: options)
        , S.select [ S.loading ] (S.Option "z" "loading" :: options)
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [] [ text "This is the select component" ]
        , simpleSelect model
        , selectStates
        ]
