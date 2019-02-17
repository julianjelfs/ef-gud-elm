module Stories.Card exposing (Model, Msg, init, update, view)

import Components.Card as C
import Components.Typography as T
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Utils exposing (loremIpsum)


type alias Model =
    {}


type Msg
    = NoOp


init : Model
init =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


titleText : String
titleText =
    "Lorem ipsum dolor sit amet, consetetu"


bodyText : String
bodyText =
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum"


defaultCard : Html Msg
defaultCard =
    div
        [ style "width" "700px" ]
        [ C.card []
            (C.imageUrl "https://images.thewest.com.au/publication/B881040182Z/1544409544889_GIQ1V8ON4.2-2.jpg?imwidth=800&impolicy=.auto")
            (C.title titleText)
            (C.body bodyText)
        ]


defaultTeaser : Html Msg
defaultTeaser =
    div
        [ style "width" "700px" ]
        [ C.teaserCard []
            (C.imageUrl "https://cdn-images-1.medium.com/max/1200/1*JNeC5fBGGLFP30_VV_mdCA.png")
            (C.title "This is a capybara")
            (C.body "Yes - with monkeys on its back")
        ]


smallTeaser : Html Msg
smallTeaser =
    div
        [ style "width" "700px" ]
        [ C.teaserCard [ C.small ]
            (C.imageUrl "https://images.thewest.com.au/publication/B881040182Z/1544409544889_GIQ1V8ON4.2-2.jpg?imwidth=800&impolicy=.auto")
            (C.title "This is the title")
            (C.body "This is a small teaser (doesn't really seem to do anything)")
        ]


verticalTeaser : Html Msg
verticalTeaser =
    div
        [ style "width" "350px" ]
        [ C.teaserCard [ C.vertical ]
            (C.imageUrl "https://img.purch.com/w/660/aHR0cDovL3d3dy5saXZlc2NpZW5jZS5jb20vaW1hZ2VzL2kvMDAwLzA0OC84NTAvb3JpZ2luYWwvY2FweWJhcmEtMDIuanBn")
            (C.title "This is the title")
            (C.body "This guy is not impressed either")
        ]


outlined : Html Msg
outlined =
    div
        [ style "width" "700px" ]
        [ C.card [ C.outline ]
            (C.imageUrl "https://nnimgt-a.akamaihd.net/transform/v1/crop/frm/7daP3m9vD5jxj8khH4ayZs/d941e787-e63d-4e51-a276-637aee16526b.JPG/r0_0_757_510_w1200_h678_fmax.jpg")
            (C.title titleText)
            (C.body bodyText)
        ]


noshadow : Html Msg
noshadow =
    div
        [ style "width" "700px"
        , style "padding" "20px"
        , style "background" "#dddddd"
        ]
        [ C.card [ C.noshadow ]
            (C.imageUrl "https://www.thetimes.co.uk/imageserver/image/methode%2Ftimes%2Fprod%2Fweb%2Fbin%2F49e8c216-5c23-11e7-ad31-8e588690cd15.jpg?crop=1500%2C844%2C0%2C78&resize=685")
            (C.title titleText)
            (C.body bodyText)
        ]


verticalCard : Html Msg
verticalCard =
    div
        [ style "width" "350px" ]
        [ C.card [ C.vertical ]
            (C.imageUrl "https://pbs.twimg.com/profile_images/959531570590871553/zwAaNjNc_400x400.jpg")
            (C.title titleText)
            (C.body bodyText)
        ]


view : Model -> Html Msg
view model =
    div []
        [ T.h5 [] [ text "Cards are used to group thematically related but distinct content" ]
        , T.h5 [] [ text "Default" ]
        , defaultCard
        , br [] []
        , T.h5 [] [ text "Vertical" ]
        , verticalCard
        , br [] []
        , T.h5 [] [ text "Outlined (for very light backgrounds)" ]
        , outlined
        , br [] []
        , T.h5 [] [ text "No Shadow (for darker backgrounds)" ]
        , noshadow
        , br [] []
        , T.h4 [] [ text "Teaser Cards" ]
        , T.para [] [ text "Teaser cards are designed for cases where a picture is worth a thousand words. The component is usually added to a link or button element, which sends the user somewhere else or triggers some new behaviour. When added to these elements it also has a hover state." ]
        , T.h5 [] [ text "Default" ]
        , defaultTeaser
        , br [] []
        , T.h5 [] [ text "Small" ]
        , smallTeaser
        , br [] []
        , T.h5 [] [ text "Vertical" ]
        , verticalTeaser
        ]
