module Components.Icon exposing
    ( Icon(..)
    , IconProp
    , icon
    , iconType
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (..)


type Icon
    = ChevronLeft
    | ChevronRight
    | ChevronUp
    | ChevronDown
    | ChevronDoubleLeft
    | ChevronDoubleRight
    | IsValid
    | IsInvalid
    | TriangleDown
    | TriangleUp
    | Users
    | Coursebook
    | Calendar
    | InfoMeeting
    | Pen
    | Phone
    | Filter
    | Insurance
    | Chat
    | Location
    | Cloud
    | Star
    | Plane
    | Facebook
    | Twitter
    | YouTube
    | LinkedIn
    | Pinterest
    | Email
    | NewWindow
    | Heart
    | HeartFilled
    | Play
    | Trash
    | Bookmark
    | Bell
    | Menu
    | Article
    | Close
    | Search
    | Info
    | Grid
    | Grid2
    | Columns
    | User
    | Gallery
    | Login


toString : Icon -> String
toString i =
    case i of
        Star ->
            "-start"

        Plane ->
            "-plane"

        Facebook ->
            "-social-fb"

        Twitter ->
            "-social-tw"

        YouTube ->
            "-social-yt"

        LinkedIn ->
            "-social-li"

        ChevronLeft ->
            "-chevron-left"

        ChevronRight ->
            "-chevron-right"

        ChevronUp ->
            "-chevron-up"

        ChevronDown ->
            "-chevron-down"

        ChevronDoubleLeft ->
            "-chevron-double-left"

        ChevronDoubleRight ->
            "-chevron-double-right"

        IsValid ->
            "-is-valid"

        IsInvalid ->
            "-is-invalid"

        TriangleDown ->
            "-triangle-down"

        TriangleUp ->
            "-triangle-up"

        Users ->
            "-users"

        Coursebook ->
            "-coursebook"

        Calendar ->
            "-calendar"

        InfoMeeting ->
            "-infomeeting"

        Pen ->
            "-pen"

        Phone ->
            "-phone"

        Filter ->
            "-filter"

        Insurance ->
            "-insurance"

        Chat ->
            "-chat"

        Location ->
            "-location"

        Cloud ->
            "-cloud"

        Pinterest ->
            "-social-pi"

        Email ->
            "-email"

        NewWindow ->
            "-new-window"

        Heart ->
            "-heart"

        HeartFilled ->
            "-heart-filled"

        Play ->
            "-play"

        Trash ->
            "-trash"

        Bookmark ->
            "-bookmark"

        Bell ->
            "-bell"

        Menu ->
            "-menu"

        Article ->
            "-article"

        Close ->
            "-close"

        Search ->
            "-search"

        Info ->
            "-info"

        Grid ->
            "-grid"

        Grid2 ->
            "-grid-2"

        Columns ->
            "-columns"

        User ->
            "-user"

        Gallery ->
            "-gallery"

        Login ->
            "-login"


iconType : Icon -> IconProp msg
iconType =
    IconProp << class << toString


type IconProp msg
    = IconProp (Attribute msg)


icon : List (IconProp msg) -> Html msg
icon props =
    span
        ([ class "ef-icon" ] ++ List.map (\(IconProp a) -> a) props)
        []
