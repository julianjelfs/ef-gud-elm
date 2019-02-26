module Stories.Icon exposing (view)

import Grid as G
import Icon as I
import Spacing as SP
import Surface as S
import Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Html msg
view =
    let
        colProps =
            [ G.bottomPad SP.Medium, G.smallSpan 12, G.mediumSpan 6, G.largeSpan 4, G.extraLargeSpan 2 ]

        exampleIcon i name =
            G.col colProps
                [ S.surface False
                    [ S.shadow, S.rounded ]
                    [ span [ style "font-size" "24px" ]
                        [ I.icon [ I.iconType i ]
                        , code [] [ text name ]
                        ]
                    ]
                ]
    in
    div
        []
        [ T.h4 [] [ text "There are lots of icons that you can use" ]
        , G.row []
            [ exampleIcon I.ChevronRight "-chevron-right"
            , exampleIcon I.ChevronLeft "-chevron-left"
            , exampleIcon I.ChevronUp "-chevron-up"
            , exampleIcon I.ChevronDown "-chevron-down"
            , exampleIcon I.ChevronDoubleLeft "-chevron-double-left"
            , exampleIcon I.ChevronDoubleRight "-chevron-double-right"
            , exampleIcon I.IsValid "-is-valid"
            , exampleIcon I.IsInvalid "-is-invalid"
            , exampleIcon I.TriangleDown "-triangle-down"
            , exampleIcon I.TriangleUp "-triangle-up"
            , exampleIcon I.Users "-users"
            , exampleIcon I.Coursebook "-coursebook"
            , exampleIcon I.Calendar "-calendar"
            , exampleIcon I.InfoMeeting "-infomeeting"
            , exampleIcon I.Pen "-pen"
            , exampleIcon I.Phone "-phone"
            , exampleIcon I.Filter "-filter"
            , exampleIcon I.Insurance "-insurance"
            , exampleIcon I.Chat "-chat"
            , exampleIcon I.Location "-location"
            , exampleIcon I.Cloud "-cloud"
            , exampleIcon I.Star "-star"
            , exampleIcon I.Plane "-plane"
            , exampleIcon I.Facebook "-social-fb"
            , exampleIcon I.Twitter "-social-tw"
            , exampleIcon I.YouTube "-social-yt"
            , exampleIcon I.LinkedIn "-social-li"
            , exampleIcon I.Pinterest "-social-pi"
            , exampleIcon I.Email "-email"
            , exampleIcon I.NewWindow "-new-window"
            , exampleIcon I.Heart "-heart"
            , exampleIcon I.HeartFilled "-heart-filled"
            , exampleIcon I.Play "-play"
            , exampleIcon I.Trash "-trash"
            , exampleIcon I.Bookmark "-bookmark"
            , exampleIcon I.Bell "-bell"
            , exampleIcon I.Menu "-menu"
            , exampleIcon I.Article "-article"
            , exampleIcon I.Close "-close"
            , exampleIcon I.Search "-search"
            , exampleIcon I.Info "-info"
            , exampleIcon I.Grid "-grid"
            , exampleIcon I.Grid2 "-grid-2"
            , exampleIcon I.Columns "-columns"
            , exampleIcon I.User "-user"
            , exampleIcon I.Gallery "-gallery"
            , exampleIcon I.Login "-login"
            ]
        ]
