module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }

--Afiseaza repozitoarele
view : Repo -> Html msg
view repo =
    div [class "repo"] [
        div [class "repo-name"] [text <| repo.name]
        ,div [class "repo-description"] [text <| Maybe.withDefault "There is no description" repo.description]
        ,div [class "repo-url"] [a [href  <| repo.url] [text <| repo.url]]
        ,div [class "repo-stars"] [(text << String.fromInt) repo.stars]
    ]


--Sorteaza repozitoarele dupa stars
sortByStars : List Repo -> List Repo
sortByStars repos =
    repos |> List.sortBy .stars


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
    De.map5 Repo
        (De.at ["name"] De.string)
        (De.maybe (De.field "description" De.string))
        (De.field "html\u{005F}url" De.string)
        (De.field "pushed\u{005F}at" De.string)
        (De.field "stargazers\u{005F}count" De.int)
