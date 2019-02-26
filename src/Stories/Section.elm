module Stories.Section exposing (view)

import Breakpoint as BP
import Color exposing (ThemeColor(..))
import Section as S
import Typography as T
import Utils exposing (loremIpsum)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Html msg
view =
    div
        []
        [ T.h4 [] [ text "This is the section component" ]
        , S.section [ S.bgColor HelloPaper, S.size BP.Small ]
            [ h3 [] [ text "This stuff is inside a SMALL section" ]
            , p [] [ text loremIpsum ]
            ]
        , S.section
            [ S.bgColor OutdoorPaper
            , S.size BP.Medium
            ]
            [ h3 [] [ text "This stuff is inside a MEDIUM section" ]
            , p [] [ text loremIpsum ]
            ]
        , S.section
            [ S.bgColor LegalPaper
            , S.size BP.Large
            ]
            [ h3 [] [ text "This stuff is inside a LARGE section" ]
            , p [] [ text loremIpsum ]
            ]
        , S.section
            [ S.bgColor EducationPaper
            , S.size BP.ExtraLarge
            ]
            [ h3 [] [ text "This stuff is inside a EXTRA LARGE section" ]
            , p [] [ text loremIpsum ]
            ]
        ]
