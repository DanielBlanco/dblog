module Components.PostList exposing (..)

import Debug
import Html exposing (Html, button, div, h2, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import List
import Post
import RemoteData exposing (WebData)
import Task


-- MODEL


type alias PostList =
    WebData (List Post.Model)


type alias Model =
    { posts : PostList }


type Msg
    = NoOp
    | Fetch PostList


initialModel : Model
initialModel =
    { posts = RemoteData.Loading }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Fetch response ->
            ( { model | posts = response }, Cmd.none )



-- VIEW
-- view : PostList -> Html a


view : Model -> Html (PostList -> Msg)
view model =
    div [ class "post-list" ]
        [ h2 [] [ text "Post List" ]
        , button [ onClick Fetch, class "btn btn-primary" ]
            [ text "Fetch Posts"
            ]
        , text "cat" --handleResponse response
        ]



-- RENDER


renderPosts : List Post.Model -> List (Html a)
renderPosts posts =
    List.map renderPost posts


renderPost : Post.Model -> Html a
renderPost post =
    li [] [ Post.view post ]


handleResponse : WebData (List Post.Model) -> Html a
handleResponse response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success posts ->
            text "cat"

        --ul [] (renderPosts posts)
        RemoteData.Failure error ->
            text (toString error)



-- Fetch


fetchPosts : Cmd Msg
fetchPosts =
    let
        url =
            "https://localhost:4000/api/posts"
    in
    Http.get url postsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Fetch



-- Decoders


postsDecoder : Decode.Decoder (List Post.Model)
postsDecoder =
    Decode.list postDecoder


postDecoder : Decode.Decoder Post.Model
postDecoder =
    decode Post.Model
        |> required "title" Decode.string
        |> required "publishedAt" Decode.string
