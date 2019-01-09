module Main exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation as Nav
import Components.Container as Container
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
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
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { key = key
      , route = urlToRoute url
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
view { route } =
    { title = "EF Web UI Kit - Elm Style"
    , body =
        List.map toUnstyled
            [ div [ class "container" ]
                [ section [ class "sidebar" ]
                    [ ul
                        []
                        [ menuItem route Button "button" "Button Component"
                        , menuItem route ButtonGroup "button-group" "Button Group Component"
                        , menuItem route Grid "grid" "Grid Component"
                        , menuItem route Input "input" "Input Component"
                        , menuItem route Section "section" "Section Component"
                        , menuItem route Surface "surface" "Surface Component"
                        , menuItem route Container "container" "Container Component"
                        ]
                    ]
                , section [ class "content" ]
                    [ h1 [] [ text "EF Web UI Kit" ]
                    , p [] [ text "A demo Elm implementation of the EF GUD 4.0 components" ]
                    , hr [] []
                    , componentView route
                    ]
                ]
            ]
    }


componentView : Route -> Html Msg
componentView route =
    case route of
        Home ->
            h2 [] [ text "Select a component" ]

        Button ->
            h2 [] [ text "Button component selected" ]

        ButtonGroup ->
            h2 [] [ text "Button Group component selected" ]

        Input ->
            h2 [] [ text "Input component selected" ]

        Section ->
            h2 [] [ text "Input component selected" ]

        Surface ->
            h2 [] [ text "Surface component selected" ]

        Container ->
            h2 [] [ Container.story ]

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
