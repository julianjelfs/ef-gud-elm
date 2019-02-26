module Color exposing (ThemeColor(..), bgColor)

import Html exposing (..)
import Html.Attributes exposing (..)


type ThemeColor
    = DigitalFirstBlue
    | EducationBlue
    | HelloPink
    | EfGrey
    | InkBlack
    | White
    | FirstPaper
    | LegalPaper
    | HelloPaper
    | EducationPaper
    | OutdoorPaper


bgColor : ThemeColor -> Attribute msg
bgColor c =
    class <|
        case c of
            DigitalFirstBlue ->
                "u-bg-first-blue"

            EducationBlue ->
                "u-bg-education-blue"

            HelloPink ->
                "u-bg-hello-pink"

            EfGrey ->
                "u-bg-ef-grey"

            InkBlack ->
                "u-bg-ink-black"

            White ->
                "u-bg-white"

            FirstPaper ->
                "u-bg-first-paper"

            LegalPaper ->
                "u-bg-legal-paper"

            HelloPaper ->
                "u-bg-hello-paper"

            EducationPaper ->
                "u-bg-education-paper"

            OutdoorPaper ->
                "u-bg-outdoor-paper"
