module Stories.Form exposing (Model, Msg, init, update, view)

import Components.Button as B
import Components.Checkbox as C
import Components.Form as F
import Components.Grid as G
import Components.Input as I
import Components.Radio as R
import Components.Typography as T
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Spacing as S
import Utils exposing (appendIf)


type alias Model =
    { formModel : F.Model FormFields
    }


type Msg
    = OnSubmit
    | FormMsg (F.Msg FormFields)


type BrochurePrefs
    = Email
    | Post
    | Both


type FormFields
    = FirstName
    | LastName


init : Model
init =
    { formModel =
        F.init
            [ F.initField FirstName (F.required |> F.and (F.maxLength 5))
            , F.initField LastName F.required
            ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FormMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    F.update subMsg model.formModel
            in
            ( { model | formModel = subModel }, Cmd.map FormMsg subCmd )

        OnSubmit ->
            ( model, Cmd.none )


exampleForm : Model -> Html (F.Msg FormFields)
exampleForm { formModel } =
    let
        firstNameInvalid =
            not <| F.fieldValid FirstName formModel

        lastNameInvalid =
            not <| F.fieldValid LastName formModel
    in
    G.row []
        [ G.col [ G.mediumSpan 10, G.largeSpan 8 ]
            [ F.form
                [ F.fieldset (F.legend "Name")
                    [ G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ F.formGroup [ FirstName ]
                                formModel
                                [ I.input
                                    ([ I.placeholder "First name"
                                     , I.required True
                                     , I.value <| F.fieldValue FirstName formModel
                                     , I.onInput (F.onInput FirstName)
                                     ]
                                        |> appendIf firstNameInvalid I.invalid
                                    )
                                , F.validationMessage FirstName formModel
                                ]
                            ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ F.formGroup [ LastName ]
                                formModel
                                [ I.input
                                    ([ I.placeholder "Last name"
                                     , I.required True
                                     , I.value <| F.fieldValue LastName formModel
                                     , I.onInput (F.onInput LastName)
                                     ]
                                        |> appendIf lastNameInvalid I.invalid
                                    )
                                , F.validationMessage LastName formModel
                                ]
                            ]
                        ]
                    ]
                , G.row [ G.verticalMargin S.Medium ]
                    [ G.col [ G.largeSpan 3, G.mediumSpan 6, G.smallSpan 8 ]
                        [ F.formGroup []
                            formModel
                            [ F.field (Just "Date of Birth")
                                (I.input [ I.placeholder "DD/MM/YYYY" ])
                            ]
                        ]
                    ]
                , F.fieldset (F.legend "How would you like to receive your brochure?")
                    [ G.row []
                        [ G.col []
                            [ F.formGroup []
                                formModel
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
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "Street Name" ] ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "Number" ] ]
                        ]
                    , G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "City" ] ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input [ I.placeholder "Post Code" ] ]
                        ]
                    ]
                , G.row []
                    [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                        [ F.formGroup []
                            formModel
                            [ F.field (Just "Email Address")
                                (I.input [ I.placeholder "Email Address" ])
                            ]
                        ]
                    , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                        [ F.formGroup []
                            formModel
                            [ F.field (Just "Phone Number")
                                (I.input [ I.placeholder "Phone Number" ])
                            ]
                        ]
                    ]
                , G.row [ G.verticalMargin S.Medium ]
                    [ G.col []
                        [ C.checkbox [] [ text "Yes, I (or my legal guardian) have read and understood how EF processes my personal data as set out in the Privacy Policy, and agree to EF's use of my personal data for marketing purposes." ]
                        ]
                    ]
                , G.row [ G.verticalMargin S.Large ]
                    [ G.col []
                        [ B.button [ B.submit, B.primary, B.disabled False ] [ text "Submit" ] ]
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
        , T.para
            [ text <|
                "Has the form been edited? "
                    ++ (if model.formModel.dirty then
                            "Yes"

                        else
                            "No"
                       )
            ]
        , T.para
            [ text <|
                "Is the form valid? "
                    ++ (if model.formModel.valid then
                            "Yes"

                        else
                            "No"
                       )
            ]
        , Html.map FormMsg <| exampleForm model
        ]
