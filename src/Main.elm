module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Css exposing (..)
import Html
import Html.Styled as SHtml exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Stories.Button as Button
import Stories.Container as Container
import Url exposing (Url)
import Url.Parser as Url



---- MODEL ----


type Route
    = Home
    | Button
    | ButtonGroup
    | Input
    | Section
    | Surface
    | Container
    | Grid
    | NotFound


type alias Model =
    { key : Nav.Key
    , route : Route
    , button : Button.Model
    , container : Container.Model
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , route = urlToRoute url
      , button = Button.init
      , container = Container.init
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


routeParser : Url.Parser (Route -> a) a
routeParser =
    Url.oneOf
        [ Url.map Home Url.top
        , Url.map Button (Url.s "button")
        , Url.map ButtonGroup (Url.s "button-group")
        , Url.map Input (Url.s "input")
        , Url.map Section (Url.s "section")
        , Url.map Surface (Url.s "surface")
        , Url.map Container (Url.s "container")
        , Url.map Grid (Url.s "grid")
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
        [ a [ href path ] [ text desc ] ]


view : Model -> Document Msg
view model =
    { title = "EF Web UI Kit - Elm Style"
    , body =
        List.map toUnstyled
            [ div [ class "container" ]
                [ section [ class "sidebar" ]
                    [ ul
                        []
                        [ menuItem model.route Button "button" "Button Component"
                        , menuItem model.route ButtonGroup "button-group" "Button Group Component"
                        , menuItem model.route Grid "grid" "Grid Component"
                        , menuItem model.route Input "input" "Input Component"
                        , menuItem model.route Section "section" "Section Component"
                        , menuItem model.route Surface "surface" "Surface Component"
                        , menuItem model.route Container "container" "Container Component"
                        ]
                    ]
                , section [ class "content" ]
                    [ h1 [] [ text "EF Web UI Kit" ]
                    , p [] [ text "A demo Elm implementation of the EF GUD 4.0 components" ]
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
            h2 [] [ text "Select a component" ]

        Button ->
            SHtml.map ButtonMsg (Button.view model.button)

        ButtonGroup ->
            h2 [] [ text "Button Group component selected" ]

        Input ->
            h2 [] [ text "Input component selected" ]

        Section ->
            h2 [] [ text "Input component selected" ]

        Surface ->
            h2 [] [ text "Surface component selected" ]

        Container ->
            SHtml.map ContainerMsg (Container.view model.container)

        Grid ->
            h2 [] [ text "Grid component selected" ]

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
