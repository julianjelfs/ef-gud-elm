module Stories.Checkbox exposing (Model, Msg, init, update, view)

import Components.Checkbox as Checkbox
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


view : Model -> Html Msg
view model =
    let
        props =
            Checkbox.defaultProps
    in
    div
        []
        [ h3 [] [ text "This is the checkbox component" ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | label = "defaul"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | checked = True
                    , label = "checked"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | focus = True
                    , label = "focused"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | disabled = True
                    , label = "disabled"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | disabled = True
                    , checked = True
                    , label = "disabled"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | validity = Checkbox.Invalid
                    , label = "invalid"
                }
            ]
        , div [ class "u-mb-m" ]
            [ Checkbox.checkbox
                { props
                    | validity = Checkbox.Invalid
                    , checked = True
                    , label = "invalid"
                }
            ]
        ]
