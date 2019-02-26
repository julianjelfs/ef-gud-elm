module Stories.Form exposing (Model, Msg, init, update, view)

import Button as B
import Checkbox as C
import Form as F
import Grid as G
import Input as I
import Radio as R
import Typography as T
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Regex as Rx
import Spacing as S
import Utils exposing (appendIf)


{-| these are the sorts of type that our form may contain
this is not very nice but I can think of no other way to
achieve a heterogeneous list of form field values
-}
type FormValueTypes
    = FormString String
    | FormBrochurePrefs BrochurePrefs


type alias Model =
    { formModel : F.Model FormFields FormValueTypes Int
    }


type Msg
    = OnSubmit
    | FormMsg (F.Msg FormFields FormValueTypes)


type BrochurePrefs
    = Email
    | Post
    | Both


type FormFields
    = FirstName
    | LastName
    | DateOfBirth
    | BrochurePreference


{-| This is important - it is a function that the form requires to convert the
sum type used to represent fields into a comparable type that can be used as a
dictionary key. It must yield a unique value for each entry or things will not
work correctly.
-}
keyFn : FormFields -> Int
keyFn f =
    case f of
        FirstName ->
            0

        LastName ->
            1

        DateOfBirth ->
            2

        BrochurePreference ->
            3


{-| validators are a problem - we cannot mix types. The initial value is of type
FormValueTypes and therefore so must the validator be. Tsk.
-}
init : Model
init =
    { formModel =
        F.init keyFn
            [ F.initField FirstName
                (FormString "")
                (F.required formValueToString
                    |> F.and
                        (F.maxLength 20
                            formValueToString
                        )
                )
            , F.initField LastName
                (FormString "")
                (F.required formValueToString
                    |> F.and
                        (F.matches upperCase
                            formValueToString
                        )
                )
            , F.initField DateOfBirth
                (FormString "")
                (F.required formValueToString
                    |> F.and
                        (F.matches dateish
                            formValueToString
                        )
                )
            , F.initField BrochurePreference (FormBrochurePrefs Email) F.nullValidator
            ]
    }


{-| yes yes we know this is not a good regex, but you get the idea
-}
dateish : Rx.Regex
dateish =
    Maybe.withDefault Rx.never <|
        Rx.fromString "\\d{2}\\/\\d{2}\\/\\d{4}"


upperCase : Rx.Regex
upperCase =
    Maybe.withDefault Rx.never <|
        Rx.fromString "^zzz"


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


prefToString : BrochurePrefs -> String
prefToString pref =
    case pref of
        Email ->
            "Email"

        Post ->
            "Post"

        Both ->
            "Both"


formValueToString : FormValueTypes -> Maybe String
formValueToString v =
    case v of
        FormString s ->
            Just s

        _ ->
            Nothing


exampleForm : Model -> Html (F.Msg FormFields FormValueTypes)
exampleForm { formModel } =
    let
        fieldInvalid f =
            not <| F.fieldValid f formModel

        stringFieldValue f =
            case F.fieldValue f formModel of
                Just v ->
                    formValueToString v

                Nothing ->
                    Nothing

        brochurePrefValueChecked v =
            case F.fieldValue BrochurePreference formModel of
                Nothing ->
                    False

                Just fv ->
                    case fv of
                        FormBrochurePrefs p ->
                            p == v

                        _ ->
                            False
    in
    G.row []
        [ G.col []
            [ F.form
                [ F.fieldset (F.legend "Name")
                    [ G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ F.formGroup [ FirstName ]
                                formModel
                                [ I.input I.TextInput
                                    ([ I.placeholder "First name"
                                     , I.required True
                                     , I.value <| stringFieldValue FirstName
                                     , I.onInput (FormString >> F.onInput FirstName)
                                     ]
                                        |> appendIf (fieldInvalid FirstName) I.invalid
                                        |> appendIf (not <| fieldInvalid FirstName) I.valid
                                    )
                                , F.validationMessage FirstName formModel
                                ]
                            ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ F.formGroup [ LastName ]
                                formModel
                                [ I.input I.TextInput
                                    ([ I.placeholder "Last name"
                                     , I.required True
                                     , I.value <| stringFieldValue LastName
                                     , I.onInput (FormString >> F.onInput LastName)
                                     ]
                                        |> appendIf (fieldInvalid LastName) I.invalid
                                        |> appendIf (not <| fieldInvalid LastName) I.valid
                                    )
                                , F.validationMessage LastName formModel
                                ]
                            ]
                        ]
                    ]
                , G.row [ G.verticalMargin S.Medium ]
                    [ G.col [ G.largeSpan 3, G.mediumSpan 6, G.smallSpan 8 ]
                        [ F.formGroup [ DateOfBirth ]
                            formModel
                            [ F.field (Just "Date of Birth")
                                (I.input I.TextInput
                                    ([ I.placeholder "DD/MM/YYYY"
                                     , I.required True
                                     , I.value <| stringFieldValue DateOfBirth
                                     , I.onInput (FormString >> F.onInput DateOfBirth)
                                     ]
                                        |> appendIf (fieldInvalid DateOfBirth) I.invalid
                                        |> appendIf (not <| fieldInvalid DateOfBirth) I.valid
                                    )
                                )
                            ]
                        ]
                    ]
                , F.fieldset (F.legend "How would you like to receive your brochure?")
                    [ G.row []
                        [ G.col []
                            [ F.formGroup []
                                formModel
                                [ R.radioGroup "validation"
                                    [ R.namedRadio
                                        ([ R.onInput (always <| F.onInput BrochurePreference (FormBrochurePrefs Email)) ]
                                            |> appendIf (brochurePrefValueChecked Email) R.checked
                                        )
                                        [ text "Email" ]
                                    , R.namedRadio
                                        ([ R.onInput (always <| F.onInput BrochurePreference (FormBrochurePrefs Post)) ]
                                            |> appendIf (brochurePrefValueChecked Post) R.checked
                                        )
                                        [ text "Post" ]
                                    , R.namedRadio
                                        ([ R.onInput (always <| F.onInput BrochurePreference (FormBrochurePrefs Both)) ]
                                            |> appendIf (brochurePrefValueChecked Both) R.checked
                                        )
                                        [ text "Email & Post" ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                , F.fieldset (F.legend "Address")
                    [ G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input I.TextInput [ I.placeholder "Street Name" ] ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input I.TextInput [ I.placeholder "Number" ] ]
                        ]
                    , G.row []
                        [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input I.TextInput [ I.placeholder "City" ] ]
                        , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                            [ I.input I.TextInput [ I.placeholder "Post Code" ] ]
                        ]
                    ]
                , G.row []
                    [ G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                        [ F.formGroup []
                            formModel
                            [ F.field (Just "Email Address")
                                (I.input I.TextInput [ I.placeholder "Email Address" ])
                            ]
                        ]
                    , G.col [ G.mediumSpan 6, G.smallSpan 12 ]
                        [ F.formGroup []
                            formModel
                            [ F.field (Just "Phone Number")
                                (I.input I.TextInput [ I.placeholder "Phone Number" ])
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
    let
        fieldTrace s f =
            s
                ++ ": "
                ++ (F.fieldValue f model.formModel
                        |> Maybe.andThen formValueToString
                        |> Maybe.withDefault "Unset"
                   )
    in
    div
        []
        [ T.h4 [] [ text "This is the form component" ]
        , T.para [] [ text "Forms use the regular grid for layout, and spacing utility classes to handle row spacing." ]
        , T.para []
            [ text <|
                "Has the form been edited? "
                    ++ (if model.formModel.dirty then
                            "Yes"

                        else
                            "No"
                       )
            ]
        , T.para []
            [ text <|
                "Is the form valid? "
                    ++ (if model.formModel.valid then
                            "Yes"

                        else
                            "No"
                       )
            ]
        , Html.map FormMsg <| exampleForm model
        , div []
            [ p [] [ code [] [ text <| fieldTrace "FirstName" FirstName ] ]
            , p [] [ code [] [ text <| fieldTrace "LastName" LastName ] ]
            , p [] [ code [] [ text <| fieldTrace "DateOfBirth" DateOfBirth ] ]
            , p []
                [ code []
                    [ text <|
                        "BrochurePreference: "
                            ++ (case F.fieldValue BrochurePreference model.formModel of
                                    Nothing ->
                                        "Unset"

                                    Just v ->
                                        case v of
                                            FormBrochurePrefs p ->
                                                prefToString p

                                            _ ->
                                                "Unset"
                               )
                    ]
                ]
            ]
        ]
