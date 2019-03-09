module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Color as C
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Input as I
import Stories.Accordion as Accordion
import Stories.Breadcrumb as Breadcrumb
import Stories.Button as Button
import Stories.CalendarComponent as Calendar
import Stories.Card as Card
import Stories.Checkbox as Checkbox
import Stories.Container as Container
import Stories.Form as Form
import Stories.Fullbleed as Fullbleed
import Stories.Grid as Grid
import Stories.Icon as Icon
import Stories.Input as Input
import Stories.Link as Link
import Stories.Logo as Logo
import Stories.Pagination as Pagination
import Stories.Radio as Radio
import Stories.Section as Section
import Stories.Select as Select
import Stories.Spacing as Spacing
import Stories.Stack as Stack
import Stories.Surface as Surface
import Stories.Switch as Switch
import Stories.Table as Table
import Stories.TextArea as TextArea
import Stories.Typography as Typography
import Typography as T
import Url exposing (Url)
import Url.Parser as Url



---- MODEL ----


type Route
    = Home
    | Button
    | Input
    | Section
    | Surface
    | Container
    | Grid
    | Stack
    | Link
    | Checkbox
    | Radio
    | Icon
    | Typography
    | Select
    | TextArea
    | Switch
    | Form
    | Logo
    | Card
    | Fullbleed
    | Accordion
    | Pagination
    | Breadcrumb
    | Table
    | Spacing
    | Calendar
    | NotFound


type alias Model =
    { key : Nav.Key
    , route : Route
    , filter : Maybe String
    , button : Button.Model
    , surface : Surface.Model
    , input : Input.Model
    , link : Link.Model
    , select : Select.Model
    , textarea : TextArea.Model
    , form : Form.Model
    , accordion : Accordion.Model
    , pagination : Pagination.Model
    , breadcrumb : Breadcrumb.Model
    , calendar : Calendar.Model
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( calendar, calendarCmd ) =
            Calendar.init
    in
    ( { key = key
      , route = urlToRoute url
      , filter = Nothing
      , button = Button.init
      , surface = Surface.init
      , input = Input.init
      , link = Link.init
      , select = Select.init
      , textarea = TextArea.init
      , form = Form.init
      , accordion = Accordion.init
      , pagination = Pagination.init
      , breadcrumb = Breadcrumb.init
      , calendar = calendar
      }
    , Cmd.map CalendarMsg calendarCmd
    )


urlToRoute : Url -> Route
urlToRoute =
    Maybe.withDefault NotFound << Url.parse routeParser



---- UPDATE ----


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
    | FilterComponents String
    | ButtonMsg Button.Msg
    | SurfaceMsg Surface.Msg
    | InputMsg Input.Msg
    | LinkMsg Link.Msg
    | SelectMsg Select.Msg
    | TextAreaMsg TextArea.Msg
    | FormMsg Form.Msg
    | AccordionMsg Accordion.Msg
    | PaginationMsg Pagination.Msg
    | BreadcrumbMsg Breadcrumb.Msg
    | CalendarMsg Calendar.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FilterComponents filter ->
            ( { model
                | filter =
                    if filter == "" then
                        Nothing

                    else
                        Just filter
              }
            , Cmd.none
            )

        OnUrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        OnUrlChange url ->
            ( { model | route = urlToRoute url }
            , Cmd.none
            )

        ButtonMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Button.update subMsg model.button
            in
            ( { model | button = subModel }, Cmd.map ButtonMsg subCmd )

        SurfaceMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Surface.update subMsg model.surface
            in
            ( { model | surface = subModel }, Cmd.map SurfaceMsg subCmd )

        InputMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Input.update subMsg model.input
            in
            ( { model | input = subModel }, Cmd.map InputMsg subCmd )

        LinkMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Link.update subMsg model.link
            in
            ( { model | link = subModel }, Cmd.map LinkMsg subCmd )

        SelectMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Select.update subMsg model.select
            in
            ( { model | select = subModel }, Cmd.map SelectMsg subCmd )

        TextAreaMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    TextArea.update subMsg model.textarea
            in
            ( { model | textarea = subModel }, Cmd.map TextAreaMsg subCmd )

        FormMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Form.update subMsg model.form
            in
            ( { model | form = subModel }, Cmd.map FormMsg subCmd )

        AccordionMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Accordion.update subMsg model.accordion
            in
            ( { model | accordion = subModel }, Cmd.map AccordionMsg subCmd )

        PaginationMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Pagination.update subMsg model.pagination
            in
            ( { model | pagination = subModel }, Cmd.map PaginationMsg subCmd )

        BreadcrumbMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Breadcrumb.update subMsg model.breadcrumb
            in
            ( { model | breadcrumb = subModel }, Cmd.map BreadcrumbMsg subCmd )

        CalendarMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Calendar.update subMsg model.calendar
            in
            ( { model | calendar = subModel }, Cmd.map CalendarMsg subCmd )


routeParser : Url.Parser (Route -> a) a
routeParser =
    Url.oneOf
        [ Url.map Home Url.top
        , Url.map Button (Url.s "button")
        , Url.map Input (Url.s "input")
        , Url.map Section (Url.s "section")
        , Url.map Surface (Url.s "surface")
        , Url.map Container (Url.s "container")
        , Url.map Grid (Url.s "grid")
        , Url.map Stack (Url.s "stack")
        , Url.map Link (Url.s "link")
        , Url.map Checkbox (Url.s "checkbox")
        , Url.map Switch (Url.s "switch")
        , Url.map Radio (Url.s "radio")
        , Url.map Icon (Url.s "icon")
        , Url.map Typography (Url.s "typography")
        , Url.map Select (Url.s "select")
        , Url.map TextArea (Url.s "textarea")
        , Url.map Form (Url.s "form")
        , Url.map Logo (Url.s "logo")
        , Url.map Card (Url.s "card")
        , Url.map Fullbleed (Url.s "fullbleed")
        , Url.map Accordion (Url.s "accordion")
        , Url.map Pagination (Url.s "pagination")
        , Url.map Breadcrumb (Url.s "breadcrumb")
        , Url.map Calendar (Url.s "calendar")
        , Url.map Table (Url.s "table")
        , Url.map Spacing (Url.s "spacing")
        ]



---- VIEW ----


menuItem : Route -> Route -> String -> String -> Html Msg
menuItem selectedRoute route path desc =
    li
        [ classList
            [ ( "selected-component"
              , selectedRoute == route
              )
            ]
        ]
        [ a [ href path ]
            [ T.body [] [ text desc ] ]
        ]


view : Model -> Document Msg
view model =
    let
        mi =
            menuItem model.route

        items =
            [ ( "Button Component", mi Button "button" )
            , ( "Input Component", mi Input "input" )
            , ( "Text Area Component", mi TextArea "textarea" )
            , ( "Select Component", mi Select "select" )
            , ( "Checkbox Component", mi Checkbox "checkbox" )
            , ( "Switch Component", mi Switch "switch" )
            , ( "Radio Component", mi Radio "radio" )
            , ( "Form Component", mi Form "form" )
            , ( "Link Component", mi Link "link" )
            , ( "Grid Component", mi Grid "grid" )
            , ( "Stack Component", mi Stack "stack" )
            , ( "Section Component", mi Section "section" )
            , ( "Surface Component", mi Surface "surface" )
            , ( "Card Component", mi Card "card" )
            , ( "Fullbleed Component", mi Fullbleed "fullbleed" )
            , ( "Container Component", mi Container "container" )
            , ( "Icon Component", mi Icon "icon" )
            , ( "Logo Component", mi Logo "logo" )
            , ( "Typography Component", mi Typography "typography" )
            , ( "Accordion Component", mi Accordion "accordion" )
            , ( "Pagination Component", mi Pagination "pagination" )
            , ( "Breadcrumb Component", mi Breadcrumb "breadcrumb" )
            , ( "Calendar Component", mi Calendar "calendar" )
            , ( "Table Component", mi Table "table" )
            , ( "Spacing Utilities", mi Spacing "spacing" )
            ]
                |> List.filter
                    (\( name, _ ) ->
                        Maybe.map (\s -> String.contains (String.toLower s) (String.toLower name)) model.filter
                            |> Maybe.withDefault True
                    )
    in
    { title = "EF Web UI Kit - Elm Style"
    , body =
        [ div [ class "container" ]
            [ section [ class "sidebar", C.bgColor C.EducationBlue ]
                [ I.input I.TextInput [ I.onInput FilterComponents, I.placeholder "Filter Components" ]
                , ul
                    []
                    (List.map (\( n, fn ) -> fn n) items)
                ]
            , section [ class "header" ]
                [ T.h1 [] [ text "EF Web UI Kit" ]
                , T.body [] [ text "A demo Elm implementation of the EF GUD 4.0 components" ]
                ]
            , section [ class "content" ]
                [ componentView model ]
            ]
        ]
    }


componentView : Model -> Html Msg
componentView model =
    case model.route of
        Home ->
            T.h4 [] [ text "Select a component from the sidebar" ]

        Button ->
            Html.map ButtonMsg (Button.view model.button)

        Link ->
            Html.map LinkMsg (Link.view model.link)

        Input ->
            Html.map InputMsg (Input.view model.input)

        Checkbox ->
            Checkbox.view

        Switch ->
            Switch.view

        Radio ->
            Radio.view

        Section ->
            Section.view

        Surface ->
            Html.map SurfaceMsg (Surface.view model.surface)

        Container ->
            Container.view

        Grid ->
            Grid.view

        Stack ->
            Stack.view

        Icon ->
            Icon.view

        Typography ->
            Typography.view

        Select ->
            Html.map SelectMsg (Select.view model.select)

        TextArea ->
            Html.map TextAreaMsg (TextArea.view model.textarea)

        Form ->
            Html.map FormMsg (Form.view model.form)

        Logo ->
            Logo.view

        Card ->
            Card.view

        Fullbleed ->
            Fullbleed.view

        Accordion ->
            Html.map AccordionMsg (Accordion.view model.accordion)

        Pagination ->
            Html.map PaginationMsg (Pagination.view model.pagination)

        Breadcrumb ->
            Html.map BreadcrumbMsg (Breadcrumb.view model.breadcrumb)

        Calendar ->
            Html.map CalendarMsg (Calendar.view model.calendar)

        Table ->
            Table.view

        Spacing ->
            Spacing.view

        NotFound ->
            T.h2 [] [ text "Unknown component selected" ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }
