module Stories.Button exposing (Model, Msg, init, update, view)

import Components.Button as B
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S


type alias Model =
    { numClicks : Int }


type Msg
    = OnClick


init : Model
init =
    { numClicks = 0 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnClick ->
            ( { model | numClicks = model.numClicks + 1 }, Cmd.none )


buttonStates : List (B.ButtonProp Msg) -> Model -> Html Msg
buttonStates props model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ exampleButton (props ++ [ B.hover ]) "Hover"
        , exampleButton (props ++ [ B.active ]) "Active"
        , exampleButton (props ++ [ B.focus ]) "Focus"
        , exampleButton (props ++ [ B.disabled True ]) "Disabled"
        , exampleButton (props ++ [ B.loading ]) "Loading"
        ]


secondaryButton : Model -> Html Msg
secondaryButton model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ exampleButton [ B.secondary ] "Lots"
        , exampleButton [ B.secondary ] "Of Nice"
        , exampleButton [ B.secondary ] "Buttons"
        ]


primaryButton : Model -> Html Msg
primaryButton model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ exampleButton [ B.primary ] "And more"
        , exampleButton [ B.primary ] "And more"
        , exampleButton [ B.primary ] "Buttons"
        ]


overrideSpacing : Model -> Html Msg
overrideSpacing model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ exampleButton [ B.primary, B.padding [ S.ExtraSmall ] ] "we can"
        , exampleButton [ B.primary, B.leftMargin S.Large, B.padding [ S.Small ] ] "override"
        , exampleButton [ B.primary, B.padding [ S.Medium ] ] "the"
        , exampleButton [ B.primary, B.padding [ S.Large ] ] "padding if"
        , exampleButton [ B.primary, B.padding [ S.ExtraLarge ] ] "we really"
        , exampleButton [ B.primary, B.padding [ S.ExtraExtraLarge ] ] "want to !!!"
        , exampleButton [ B.primary, B.padding [ S.Zero, S.Large ] ] "also uneven"
        , exampleButton [ B.primary, B.padding [ S.Zero, S.Large, S.Medium ] ] "padding is fine"
        , exampleButton
            [ B.primary
            , B.topPad S.ExtraExtraLarge
            ]
            "totally fine"
        ]


smallButtons : Model -> Html Msg
smallButtons model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ exampleButton [ B.primary, B.small ] "Slightly smaller"
        , exampleButton [ B.secondary, B.small ] "than normal button"
        ]


exampleButton : List (B.ButtonProp Msg) -> String -> Html Msg
exampleButton props txt =
    B.button (B.onClick OnClick :: props) [ text txt ]


view : Model -> Html Msg
view model =
    let
        defaultProps =
            [ B.primary, B.onClick OnClick ]

        secondaryProps =
            [ B.secondary, B.onClick OnClick ]

        squareProps =
            [ B.square, B.secondary, B.onClick OnClick ]
    in
    div
        []
        [ T.h4 [] [ text "This is the button component" ]
        , primaryButton model
        , buttonStates defaultProps model
        , secondaryButton model
        , buttonStates secondaryProps model
        , buttonStates squareProps model
        , smallButtons model
        , overrideSpacing model
        , div [ class "u-s-p-s" ]
            [ pre []
                [ text <|
                    "Number of button clicks: "
                        ++ String.fromInt
                            model.numClicks
                ]
            ]
        ]
