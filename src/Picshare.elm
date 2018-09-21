module Picshare exposing (main)

import Html exposing (Html, div, h1, h2, img, text, i)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Browser


type alias Photo =
    { url : String
    , caption : String
    , liked : Bool
    }

type Msg
    = Like
    | Unlike

initialModel : Photo
initialModel = 
    { url = "https://programming-elm.com/1.jpg"
    , caption = "Surfing"
    , liked = False
    }

update : Msg -> Photo -> Photo
update msg model =
    case msg of
        Like -> { model | liked = True }
        Unlike -> { model | liked = False }


viewPhoto : Photo -> Html Msg
viewPhoto model =
    let
        buttonClass = if model.liked then "fa-heart" else "fa-heart-o"
        msg = if model.liked then Unlike else Like
    in
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ]
            [ div [ class "like-button"]
                [ i
                    [ class "fa fa-2x"
                    , class buttonClass
                    , onClick msg
                    ]
                    []
            ]
            ]
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