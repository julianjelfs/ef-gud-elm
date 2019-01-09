module Theme exposing (Theme, theme)

import Css as Css


type alias Theme =
    { colors : Colors
    }


type alias Colors =
    { digitalFirstBlue : Css.Color
    , educationBlue : Css.Color
    , helloPink : Css.Color
    , efGrey : Css.Color
    , inkBlack : Css.Color
    , white : Css.Color
    }


colors : Colors
colors =
    { digitalFirstBlue = Css.hex "009EE8"
    , educationBlue = Css.hex "003C64"
    , helloPink = Css.hex "FF329B"
    , efGrey = Css.hex "EFEFEF"
    , inkBlack = Css.hex "191919"
    , white = Css.hex "FFFFFF"
    }


theme : Theme
theme =
    { colors = colors
    }