module Main exposing (..)

import Components.PostList as PostList
import Html exposing (Html, div, program, text)
import Html.Attributes exposing (class)


-- MODEL


type alias Model =
    { postListModel : PostList.Model }


type Msg
    = PostListMsg PostList.Msg


initialModel : Model
initialModel =
    { postListModel = PostList.initialModel }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PostListMsg postMsg ->
            let
                ( updatedModel, cmd ) =
                    PostList.update postMsg model.postListModel
            in
            ( { model | postListModel = updatedModel }
            , Cmd.map PostListMsg cmd
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ Html.map PostListMsg (PostList.view model.postListModel) ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
