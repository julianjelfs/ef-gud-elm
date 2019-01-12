module Stories.Button exposing (Model, Msg, init, update, view)

import Components.Button as Button
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, disabled, href, src)
import Html.Styled.Events exposing (onClick)


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


view : Model -> Html Msg
view model =
    div
        []
        [ h2 [] [ text "This is the button component" ]
        , div [ css paddedBox ] [ Button.buttonComponent defaultButtonProps ]
        , div [ css paddedBox ] [ Button.buttonComponent { defaultButtonProps | disabled = True } ]
        , div [ css paddedBox ] [ Button.buttonComponent { defaultButtonProps | shape = Button.Square } ]
        , div [ css paddedBox ] [ Button.buttonComponent { defaultButtonProps | size = Button.Small } ]
        , div []
            [ p []
                [ text <|
                    "Number of button clicks: "
                        ++ String.fromInt
                            model.numClicks
                ]
            ]
        ]


defaultButtonProps : Button.ButtonProps Msg
defaultButtonProps =
    let
        p =
            Button.defaultProps
    in
    { p | text = "Clicky Button!", onClick = Just OnClick }


paddedBox : List Style
paddedBox =
    [ padding (px 10) ]
