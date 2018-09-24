module Picshare exposing (main)

import Browser
import Html exposing (Html, button, div, form, h1, h2, i, img, input, li, strong, text, ul)
import Html.Attributes exposing (class, disabled, href, placeholder, src, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)


type alias Photo =
    { url : String
    , caption : String
    , liked : Bool
    , comments : List String
    , newComment : String
    }


type Msg
    = ToggleLike
    | UpdateComment String
    | SaveComment


initialModel : Photo
initialModel =
    { url = "https://placeimg.com/640/480/nature"
    , caption = "Nature"
    , liked = False
    , comments = [ "Wow" ]
    , newComment = ""
    }


update : Msg -> Photo -> Photo
update msg model =
    case msg of
        ToggleLike ->
            { model | liked = not model.liked }

        UpdateComment comment ->
            { model | newComment = comment }

        SaveComment ->
            case String.trim model.newComment of
                "" ->
                    model

                comment ->
                    { model
                        | comments = model.comments ++ [ comment ]
                        , newComment = ""
                    }


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


viewComment : String -> Html Msg
viewComment comment =
    li []
        [ strong [] [ text "Comment:" ]
        , text (" " ++ comment)
        ]


viewCommentList : List String -> Html Msg
viewCommentList comments =
    case comments of
        [] ->
            text ""

        _ ->
            div [ class "comments" ]
                [ ul []
                    (List.map viewComment comments)
                ]


viewComments : Photo -> Html Msg
viewComments model =
    div []
        [ viewCommentList model.comments
        , form [ class "new-comment", onSubmit SaveComment ]
            [ input
                [ type_ "text"
                , placeholder "Add a comment..."
                , value model.newComment
                , onInput UpdateComment
                ]
                []
            , button
                [ disabled (String.isEmpty model.newComment) ]
                [ text "Save" ]
            ]
        ]


viewPhoto : Photo -> Html Msg
viewPhoto model =
    div [ class "detailed-photo" ]
        [ img [ src model.url ] []
        , div [ class "photo-info" ] [ viewLoveButton model ]
        , h2 [ class "caption" ] [ text model.caption ]
        , viewComments model
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
