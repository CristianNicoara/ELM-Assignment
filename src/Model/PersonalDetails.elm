module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


--Afisarea datelor personale
view : PersonalDetails -> Html msg
view details =
    div [] [
        div [id "name"] [ h1 [] [text <| details.name]]
        ,div [id "intro"] [ em [] [text <| details.intro]]
        ,div [class "contact-detail"] [p [] (List.map (\l -> p [] [text <| l.detail]) details.contacts)]
        ,div [class "social-link"] [p [] (List.map (\l -> p [] [a [href  <| l.detail] [text <| l.name]]) details.socials)]
    ]
