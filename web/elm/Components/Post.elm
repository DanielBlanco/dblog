module Post exposing (Model, view)

import Html exposing (Html, a, em, span, strong, text)
import Html.Attributes exposing (class, href)


-- MODEL


type alias Model =
    { title : String, publishedAt : String }



-- VIEW


view : Model -> Html a
view model =
    span [ class "article" ]
        [ a [ href "" ] [ strong [] [ text model.title ] ]
        , em [] [ text (" (published at: " ++ model.publishedAt ++ ")") ]
        ]
