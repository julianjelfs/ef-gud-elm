module Stories.Form exposing (Model, Msg, init, update, view)

import Components.Checkbox as C
import Components.Form as F
import Components.Grid as G
import Components.Input as I
import Components.Radio as R
import Components.Typography as T
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


exampleForm : Html Msg
exampleForm =
    G.row []
        [ G.col [ G.mediumSpan 10, G.largeSpan 8 ]
            [ F.form
                [ F.fieldset (F.legend "Name")
                    [ G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "First name" ] ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "Last name" ] ]
                        ]
                    ]
                , G.row []
                    [ G.col [ G.largeSpan 3, G.mediumSpan 6, G.smallSpan 8 ]
                        [ F.formGroup
                            [ F.field (Just "Date of Birth")
                                [ I.input [ I.placeholder "DD/MM/YYYY" ] ]
                            ]
                        ]
                    ]
                , F.fieldset (F.legend "How would you like to receive your brochure?")
                    [ G.row []
                        [ G.col []
                            [ F.formGroup
                                [ R.radioGroup "validation"
                                    [ R.namedRadio [ R.checked ] [ text "Email" ]
                                    , R.namedRadio [] [ text "Post" ]
                                    , R.namedRadio [] [ text "Email & Post" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , F.fieldset (F.legend "Address")
                    [ G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "Stree name" ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "Number" ]
                        ]
                    , G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "City" ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "Post Code" ]
                        ]
                    ]
                , G.row []
                    [ G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "Email Address" ]
                    , G.col [ G.mediumSpan 6, G.smallSpan 12 ] [ text "Phone number" ]
                    ]
                , G.row []
                    [ G.col [] [ text "Legal checkbox stuff" ]
                    ]
                , G.row []
                    [ G.col [] [ text "Submit button" ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div
        []
        [ T.h4 [ text "This is the form component" ]
        , T.para [ text "Forms use the regular grid for layout, and spacing utility classes to handle row spacing." ]
        , exampleForm
        ]
