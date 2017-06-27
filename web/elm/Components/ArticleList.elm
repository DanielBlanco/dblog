module Components.ArticleList exposing (..)

import Article
import Html exposing (Html, button, div, h2, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import List


type alias Model =
    { articles : List Article.Model }


type Msg
    = NoOp
    | Fetch


initialModel : Model
initialModel =
    { articles = [] }


articles : Model
articles =
    { articles =
        [ { title = "Article 1"
          , url = "http://google.com"
          , postedBy = "Author"
          , postedOn = "06/20/16"
          }
        , { title = "Article 2"
          , url = "http://google.com"
          , postedBy = "Author 2"
          , postedOn = "06/20/16"
          }
        , { title = "Article 3"
          , url = "http://google.com"
          , postedBy = "Author 3"
          , postedOn = "06/20/16"
          }
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Fetch ->
            ( articles, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "article-list" ]
        [ h2 [] [ text "Article List" ]
        , button [ onClick Fetch, class "btn btn-primary" ]
            [ text "Fetch Articles"
            ]
        , ul [] (renderArticles model)
        ]


renderArticle : Article.Model -> Html a
renderArticle article =
    li [] [ Article.view article ]


renderArticles : Model -> List (Html a)
renderArticles model =
    List.map renderArticle model.articles
