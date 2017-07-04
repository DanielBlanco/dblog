module Components.PostList exposing (..)

import Debug
import Html exposing (Html, button, div, h2, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import List
import Post
import RemoteData exposing (WebData)
import Task


-- MODEL


type alias Posts =
    List Post.Model


type alias WebPosts =
    WebData Posts


type alias Model =
    { posts : WebPosts }


initialModel : Model
initialModel =
    { posts = RemoteData.Loading }



-- UPDATE


type Msg
    = NoOp
    | GetPosts
    | PostsResponse WebPosts


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetPosts ->
            ( model, getPosts )

        PostsResponse response ->
            ( { model | posts = response }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "post-list" ]
        [ h2 [] [ text "Post List" ]
        , button [ onClick GetPosts, class "btn btn-primary" ]
            [ text "Fetch Posts"
            ]
        , viewModel model
        ]


viewModel : Model -> Html msg
viewModel model =
    case model.posts of
        RemoteData.NotAsked ->
            text "Initializing."

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Failure err ->
            text ("Error: " ++ toString err)

        RemoteData.Success posts ->
            ul [] (viewPosts posts)


viewPosts : Posts -> List (Html a)
viewPosts posts =
    List.map viewPost posts


viewPost : Post.Model -> Html a
viewPost post =
    li [] [ Post.view post ]



-- EVENTS


getPosts : Cmd Msg
getPosts =
    let
        route =
            "/api/posts"
    in
    Http.get route decodePosts
        |> RemoteData.sendRequest
        |> Cmd.map PostsResponse



-- Decoders


decodePosts : Decode.Decoder Posts
decodePosts =
    Decode.map identity
        (Decode.field "data" (Decode.list decodePost))


decodePost : Decode.Decoder Post.Model
decodePost =
    decode Post.Model
        |> requiredAt [ "attributes", "title" ] Decode.string
        |> requiredAt [ "attributes", "published-at" ] Decode.string
