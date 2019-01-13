module Theme exposing (Theme, theme)

import Css as Css


type alias Theme =
    { colors : Colors
    }


type alias BorderColors =
    { interactive : Css.Color }


type alias TextColors =
    { light : Css.Color
    }


type alias Colors =
    { digitalFirstBlue : Css.Color
    , educationBlue : Css.Color
    , helloPink : Css.Color
    , efGrey : Css.Color
    , inkBlack : Css.Color
    , white : Css.Color
    , border : BorderColors
    , primary : Css.Color
    , text : TextColors
    }


colors : Colors
colors =
    { digitalFirstBlue = Css.hex "009EE8"
    , educationBlue = Css.hex "003C64"
    , helloPink = Css.hex "FF329B"
    , efGrey = Css.hex "EFEFEF"
    , inkBlack = Css.hex "191919"
    , white = Css.hex "FFFFFF"
    , border = BorderColors <| Css.hex "191919"
    , primary = Css.hex "003C64"
    , text = TextColors <| Css.hex "FFFFFF"
    }


theme : Theme
theme =
    { colors = colors
    }
