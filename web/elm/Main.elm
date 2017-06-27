module Main exposing (..)

import Components.ArticleList as ArticleList
import Html exposing (Html, div, program, text)
import Html.Attributes exposing (class)


-- MODEL


type alias Model =
    { articleListModel : ArticleList.Model }


type Msg
    = ArticleListMsg ArticleList.Msg


initialModel : Model
initialModel =
    { articleListModel = ArticleList.initialModel }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ArticleListMsg articleMsg ->
            let
                ( updatedModel, cmd ) =
                    ArticleList.update articleMsg model.articleListModel
            in
            ( { model | articleListModel = updatedModel }
            , Cmd.map ArticleListMsg cmd
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ Html.map ArticleListMsg (ArticleList.view model.articleListModel) ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
