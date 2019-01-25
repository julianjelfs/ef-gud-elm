module Stories.Input exposing (Model, Msg, init, update, view)

import Components.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


inputTypes : List (Html Msg)
inputTypes =
    let
        props =
            Input.defaultProps
    in
    [ div [] [ Input.inputComponent { props | placeholder = Just "type: text" } ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: email"
                , type_ =
                    Input.EmailInput
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: number"
                , type_ =
                    Input.NumberInput
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: password"
                , type_ =
                    Input.PasswordInput
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: search"
                , type_ =
                    Input.SearchInput
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: tel"
                , type_ =
                    Input.TelInput
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "type: url"
                , type_ =
                    Input.UrlInput
            }
        ]
    ]


inputStates : List (Html Msg)
inputStates =
    let
        props =
            Input.defaultProps
    in
    [ div []
        [ Input.inputComponent
            { props
                | placeholder =
                    Just "untouched"
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "focused"
                , focus = True
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "completed"
                , completed = True
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "disabled"
                , disabled = True
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "valid"
                , validity = Input.Valid
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "invalid"
                , validity = Input.Invalid
            }
        ]
    , div []
        [ Input.inputComponent
            { props
                | placeholder = Just "loading"
                , loading = True
            }
        ]
    ]


view : Model -> Html Msg
view model =
    div
        []
        ([ h3 [] [ text "This is the input component" ]
         ]
            ++ [ h5 [] [ text "These are the input types" ] ]
            ++ inputTypes
            ++ [ br [] [], h5 [] [ text "These are the interaction states" ] ]
            ++ inputStates
        )
