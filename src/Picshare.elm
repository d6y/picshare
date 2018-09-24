module Picshare exposing (main)

import Browser
import Html exposing (Html, div, h1, h2, i, img, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)


type alias Photo =
    { url : String
    , caption : String
    , liked : Bool
    }


type Msg
    = ToggleLike


initialModel : Photo
initialModel =
    { url = "https://placeimg.com/640/480/nature"
    , caption = "Nature"
    , liked = False
    }


update : Msg -> Photo -> Photo
update msg model =
    case msg of
        ToggleLike ->
            { model | liked = not model.liked }

viewLoveButton : Photo -> Html Msg
viewLoveButton model =
    let
        buttonClass =
            if model.liked then
                "fa-heart"
            else
                "fa-heart-o"
    in
    div [ class "like-button" ]
        [ i
            [ class "fa fa-2x"
            , class buttonClass
            , onClick ToggleLike
            ]
            []
        ]

viewPhoto : Photo -> Html Msg
viewPhoto model =
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ] [ viewLoveButton model ]
        , h2 [ class "caption" ] [ text model.caption ]
        ]


view : Photo -> Html Msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewPhoto model ]
        ]


main : Program () Photo Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
