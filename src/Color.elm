module Color exposing (ThemeColor(..), backgroundClass)


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


backgroundClass : ThemeColor -> String
backgroundClass c =
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
