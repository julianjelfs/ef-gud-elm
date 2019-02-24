module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Color as C
import Components.Input as I
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Stories.Accordion as Accordion
import Stories.Breadcrumb as Breadcrumb
import Stories.Button as Button
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
import Stories.Stack as Stack
import Stories.Surface as Surface
import Stories.Switch as Switch
import Stories.TextArea as TextArea
import Stories.Typography as Typography
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
    | NotFound


type alias Model =
    { key : Nav.Key
    , route : Route
    , button : Button.Model
    , container : Container.Model
    , section : Section.Model
    , surface : Surface.Model
    , input : Input.Model
    , grid : Grid.Model
    , stack : Stack.Model
    , link : Link.Model
    , checkbox : Checkbox.Model
    , radio : Radio.Model
    , icon : Icon.Model
    , typography : Typography.Model
    , select : Select.Model
    , textarea : TextArea.Model
    , switch : Switch.Model
    , form : Form.Model
    , logo : Logo.Model
    , card : Card.Model
    , fullbleed : Fullbleed.Model
    , accordion : Accordion.Model
    , pagination : Pagination.Model
    , breadcrumb : Breadcrumb.Model
    , filter : Maybe String
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , route = urlToRoute url
      , button = Button.init
      , container = Container.init
      , section = Section.init
      , surface = Surface.init
      , input = Input.init
      , grid = Grid.init
      , stack = Stack.init
      , link = Link.init
      , checkbox = Checkbox.init
      , radio = Radio.init
      , icon = Icon.init
      , typography = Typography.init
      , select = Select.init
      , textarea = TextArea.init
      , switch = Switch.init
      , form = Form.init
      , logo = Logo.init
      , card = Card.init
      , fullbleed = Fullbleed.init
      , accordion = Accordion.init
      , pagination = Pagination.init
      , breadcrumb = Breadcrumb.init
      , filter = Nothing
      }
    , Cmd.none
    )


urlToRoute : Url -> Route
urlToRoute =
    Maybe.withDefault NotFound << Url.parse routeParser



---- UPDATE ----


type Msg
    = OnUrlRequest UrlRequest
    | OnUrlChange Url
    | ButtonMsg Button.Msg
    | ContainerMsg Container.Msg
    | SectionMsg Section.Msg
    | SurfaceMsg Surface.Msg
    | InputMsg Input.Msg
    | GridMsg Grid.Msg
    | StackMsg Stack.Msg
    | LinkMsg Link.Msg
    | CheckboxMsg Checkbox.Msg
    | RadioMsg Radio.Msg
    | IconMsg Icon.Msg
    | TypographyMsg Typography.Msg
    | SelectMsg Select.Msg
    | TextAreaMsg TextArea.Msg
    | SwitchMsg Switch.Msg
    | FormMsg Form.Msg
    | LogoMsg Logo.Msg
    | CardMsg Card.Msg
    | FullbleedMsg Fullbleed.Msg
    | AccordionMsg Accordion.Msg
    | PaginationMsg Pagination.Msg
    | BreadcrumbMsg Breadcrumb.Msg
    | FilterComponents String


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

        ContainerMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Container.update subMsg model.container
            in
            ( { model | container = subModel }, Cmd.map ContainerMsg subCmd )

        SectionMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Section.update subMsg model.section
            in
            ( { model | section = subModel }, Cmd.map SectionMsg subCmd )

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

        GridMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Grid.update subMsg model.grid
            in
            ( { model | grid = subModel }, Cmd.map GridMsg subCmd )

        StackMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Stack.update subMsg model.stack
            in
            ( { model | stack = subModel }, Cmd.map StackMsg subCmd )

        LinkMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Link.update subMsg model.link
            in
            ( { model | link = subModel }, Cmd.map LinkMsg subCmd )

        CheckboxMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Checkbox.update subMsg model.checkbox
            in
            ( { model | checkbox = subModel }, Cmd.map CheckboxMsg subCmd )

        RadioMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Radio.update subMsg model.radio
            in
            ( { model | radio = subModel }, Cmd.map RadioMsg subCmd )

        IconMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Icon.update subMsg model.icon
            in
            ( { model | icon = subModel }, Cmd.map IconMsg subCmd )

        TypographyMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Typography.update subMsg model.typography
            in
            ( { model | typography = subModel }, Cmd.map TypographyMsg subCmd )

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

        SwitchMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Switch.update subMsg model.switch
            in
            ( { model | switch = subModel }, Cmd.map SwitchMsg subCmd )

        FormMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Form.update subMsg model.form
            in
            ( { model | form = subModel }, Cmd.map FormMsg subCmd )

        LogoMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Logo.update subMsg model.logo
            in
            ( { model | logo = subModel }, Cmd.map LogoMsg subCmd )

        CardMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Card.update subMsg model.card
            in
            ( { model | card = subModel }, Cmd.map CardMsg subCmd )

        FullbleedMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    Fullbleed.update subMsg model.fullbleed
            in
            ( { model | fullbleed = subModel }, Cmd.map FullbleedMsg subCmd )

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
            Html.map CheckboxMsg (Checkbox.view model.checkbox)

        Switch ->
            Html.map SwitchMsg (Switch.view model.switch)

        Radio ->
            Html.map RadioMsg (Radio.view model.radio)

        Section ->
            Html.map SectionMsg (Section.view model.section)

        Surface ->
            Html.map SurfaceMsg (Surface.view model.surface)

        Container ->
            Html.map ContainerMsg (Container.view model.container)

        Grid ->
            Html.map GridMsg (Grid.view model.grid)

        Stack ->
            Html.map StackMsg (Stack.view model.stack)

        Icon ->
            Html.map IconMsg (Icon.view model.icon)

        Typography ->
            Html.map TypographyMsg (Typography.view model.typography)

        Select ->
            Html.map SelectMsg (Select.view model.select)

        TextArea ->
            Html.map TextAreaMsg (TextArea.view model.textarea)

        Form ->
            Html.map FormMsg (Form.view model.form)

        Logo ->
            Html.map LogoMsg (Logo.view model.logo)

        Card ->
            Html.map CardMsg (Card.view model.card)

        Fullbleed ->
            Html.map FullbleedMsg (Fullbleed.view model.fullbleed)

        Accordion ->
            Html.map AccordionMsg (Accordion.view model.accordion)

        Pagination ->
            Html.map PaginationMsg (Pagination.view model.pagination)

        Breadcrumb ->
            Html.map BreadcrumbMsg (Breadcrumb.view model.breadcrumb)

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
