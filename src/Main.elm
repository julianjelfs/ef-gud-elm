module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Stories.Button as Button
import Stories.Checkbox as Checkbox
import Stories.Container as Container
import Stories.Grid as Grid
import Stories.Icon as Icon
import Stories.Input as Input
import Stories.Link as Link
import Stories.Radio as Radio
import Stories.Section as Section
import Stories.Select as Select
import Stories.Stack as Stack
import Stories.Surface as Surface
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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
        , Url.map Radio (Url.s "radio")
        , Url.map Icon (Url.s "icon")
        , Url.map Typography (Url.s "typography")
        , Url.map Select (Url.s "select")
        , Url.map TextArea (Url.s "textarea")
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
            [ T.body [ text desc ] ]
        ]


view : Model -> Document Msg
view model =
    { title = "EF Web UI Kit - Elm Style"
    , body =
        [ div [ class "container" ]
            [ section [ class "sidebar" ]
                [ ul
                    []
                    [ menuItem model.route Button "button" "Button Component"
                    , menuItem model.route Link "link" "Link Component"
                    , menuItem model.route Grid "grid" "Grid Component"
                    , menuItem model.route Stack "stack" "Stack Component"
                    , menuItem model.route Input "input" "Input Component"
                    , menuItem model.route TextArea "textarea" "Text Area Component"
                    , menuItem model.route Select "select" "Select Components"
                    , menuItem model.route Checkbox "checkbox" "Checkbox Component"
                    , menuItem model.route Radio "radio" "Radio Component"
                    , menuItem model.route Section "section" "Section Component"
                    , menuItem model.route Surface "surface" "Surface Component"
                    , menuItem model.route Container "container" "Container Component"
                    , menuItem model.route Icon "icon" "Icon Component"
                    , menuItem model.route Typography "typography" "Typography Components"
                    ]
                ]
            , section [ class "content" ]
                [ T.h1 [ text "EF Web UI Kit" ]
                , T.body [ text "A demo Elm implementation of the EF GUD 4.0 components" ]
                , hr [] []
                , componentView model
                ]
            ]
        ]
    }


componentView : Model -> Html Msg
componentView model =
    case model.route of
        Home ->
            T.h4 [ text "Select a component from the sidebar" ]

        Button ->
            Html.map ButtonMsg (Button.view model.button)

        Link ->
            Html.map LinkMsg (Link.view model.link)

        Input ->
            Html.map InputMsg (Input.view model.input)

        Checkbox ->
            Html.map CheckboxMsg (Checkbox.view model.checkbox)

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

        NotFound ->
            h2 [] [ text "Unknown component selected" ]



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
