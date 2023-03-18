module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (..)
import Model.Date as Date exposing (..)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"

--Funtia de sortare a intervalelor care apeleaza functia compare din Interval 
sortFunction : Event -> Event -> Order
sortFunction event1 event2 = Interval.compare event1.interval event2.interval

--Sorteaza Intervalele
sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith sortFunction events


--Afisarea evenimentelor
view : Event -> Html Never
view event =
    div [classList [("event", True), ("event-important", event.important)]] [
        div [class "event-title" ] [text event.title]
        ,div [class "event-description"] [event.description]
        ,div [class "event-category"] [categoryView event.category]
        ,div [class "event-url"] [text (Maybe.withDefault  "Doesn't exist" event.url)]
        ,div [class "event-interval"][Interval.view event.interval]
    ]
