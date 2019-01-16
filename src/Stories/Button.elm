module Stories.Button exposing (Model, Msg, init, update, view)

import Components.Button as Button
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


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


buttonStates : Button.ButtonProps Msg -> Model -> Html Msg
buttonStates props model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ Button.buttonComponent
            { props
                | text = "Hover"
                , hover = True
            }
        , Button.buttonComponent
            { props
                | text = "Active"
                , active = True
            }
        , Button.buttonComponent
            { props
                | text = "Focus"
                , focus = True
            }
        , Button.buttonComponent
            { props
                | text = "Disabled"
                , disabled = True
            }
        , Button.buttonComponent
            { props
                | text = "Loading"
                , loading = True
            }
        ]


secondaryButton : Model -> Html Msg
secondaryButton model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ Button.buttonComponent
            { secondaryButtonProps
                | text = "Lots"
            }
        , Button.buttonComponent
            { secondaryButtonProps
                | text = "Of Nice"
            }
        , Button.buttonComponent
            { secondaryButtonProps
                | text = "Buttons"
            }
        ]


primaryButton : Model -> Html Msg
primaryButton model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ Button.buttonComponent
            { defaultButtonProps
                | text = "And more"
            }
        , Button.buttonComponent
            { defaultButtonProps
                | text = "And more"
            }
        , Button.buttonComponent
            { defaultButtonProps
                | text = "Buttons"
            }
        ]


smallButtons : Model -> Html Msg
smallButtons model =
    div
        [ class "ef-button-group u-s-p-s" ]
        [ Button.buttonComponent
            { defaultButtonProps
                | text = "Slight smaller"
                , size = Button.Small
            }
        , Button.buttonComponent
            { secondaryButtonProps
                | text = "than normal buttons"
                , size = Button.Small
            }
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ h3 [] [ text "This is the button component" ]
        , primaryButton model
        , buttonStates defaultButtonProps model
        , secondaryButton model
        , buttonStates secondaryButtonProps model
        , buttonStates squareButtonProps model
        , smallButtons model
        , div [ class "u-s-p-s" ]
            [ pre []
                [ text <|
                    "Number of button clicks: "
                        ++ String.fromInt
                            model.numClicks
                ]
            ]
        ]


squareButtonProps : Button.ButtonProps Msg
squareButtonProps =
    { secondaryButtonProps | shape = Button.Square }


secondaryButtonProps : Button.ButtonProps Msg
secondaryButtonProps =
    { defaultButtonProps | buttonType = Button.Secondary }


defaultButtonProps : Button.ButtonProps Msg
defaultButtonProps =
    let
        p =
            Button.defaultProps
    in
    { p | text = "Clicky Button!", onClick = Just OnClick }
