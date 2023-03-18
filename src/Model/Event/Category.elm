module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ] 

{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    =  SelectedEventCategories (List EventCategory)


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    SelectedEventCategories eventCategories
    --Debug.todo "Implement Model.Event.Category.allSelected"

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
    SelectedEventCategories []
    --Debug.todo "Implement Model.Event.Category.noneSelected"

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    let
        isEventCategorySelectedAux category2 current2 =
            case current2 of
                [] -> False
                x::xs -> if x == category2 then
                            True
                        else
                            isEventCategorySelectedAux category2 xs
    in
        case current of
            SelectedEventCategories l -> isEventCategorySelectedAux category l

    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    let
        setAux category2 l = 
            case l of 
                [] -> []
                x::xs -> if x == category then
                            xs
                        else
                            x::(setAux category2 xs)
    in
        if (value == True) then
            case isEventCategorySelected category current of
                True -> current
                False -> case current of
                            SelectedEventCategories l -> SelectedEventCategories (l ++ [category]) 
        else
            case isEventCategorySelected category current of
                True -> case current of
                            SelectedEventCategories l -> SelectedEventCategories (setAux category l)
                False -> current

    --Debug.todo "Implement Model.Event.Category.set"


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]

--Afiseaza categoriile ca checkbox-uri
view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    div [] [
        checkbox "Academic" (isEventCategorySelected Academic model) Academic
        ,checkbox "Work" (isEventCategorySelected Work model) Work
        ,checkbox "Project" (isEventCategorySelected Project model) Project
        ,checkbox "Award" (isEventCategorySelected Award model) Award
    ]
    --Debug.todo "Implement the Model.Event.Category.view function"
