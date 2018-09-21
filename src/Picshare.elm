module Picshare exposing (main)

import Html exposing (Html, div, h1, h2, img, text)
import Html.Attributes exposing (class, href, src)


viewPhoto : String -> String -> Html msg
viewPhoto filename caption =
    div [ class "detailed-photo" ]
        [ img [ src ("https://programming-elm.com/" ++ filename) ] []
        , div [ class "photo-info" ]
            [ h2 [ class "caption" ] [ text caption ] ]
        ]


main : Html msg
main =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewPhoto "1.jpg" "Surfing"
            , viewPhoto "2.jpg" "The Fox"
            , viewPhoto "3.jpg" "Evening"
            ]
        ]
