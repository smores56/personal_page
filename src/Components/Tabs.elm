module Components.Tabs exposing (TabName(..), tabs)

import Components.AtWork exposing (atWorkTab)
import Components.OnTheSide exposing (onTheSideTab)
import Components.PersonalProjects exposing (projectsTab)
import Components.Skills exposing (skillsTab)
import Html exposing (Html, a, div, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Sudoku.Game


type TabName
    = TabSkills
    | TabWork
    | TabProjects
    | TabFun


type alias TabContext msg =
    { currentTab : TabName
    , sudoku : Sudoku.Game.Model
    , sudokuMsg : Sudoku.Game.Msg -> msg
    , clickTab : TabName -> msg
    , playChord : List String -> msg
    , playTheLick : msg
    }


tabLabel : TabName -> String
tabLabel tab =
    case tab of
        TabSkills ->
            "Skills"

        TabWork ->
            "Work"

        TabProjects ->
            "Projects"

        TabFun ->
            "Fun"


tabContent : TabContext msg -> TabName -> Html msg
tabContent context tab =
    case tab of
        TabSkills ->
            skillsTab

        TabWork ->
            atWorkTab

        TabProjects ->
            projectsTab

        TabFun ->
            onTheSideTab context.playTheLick context.playChord context.sudokuMsg context.sudoku


tabs : TabContext msg -> Html msg
tabs context =
    let
        allTabs =
            [ TabWork, TabProjects, TabSkills, TabFun ]

        tabButton tab =
            li []
                [ a
                    [ class
                        ("button"
                            ++ (if tab == context.currentTab then
                                    " active"

                                else
                                    ""
                               )
                        )
                    , onClick (context.clickTab tab)
                    ]
                    [ text (tabLabel tab) ]
                ]

        tabPane tab =
            div
                [ class
                    ("tab-pane"
                        ++ (if tab == context.currentTab then
                                " active"

                            else
                                ""
                           )
                    )
                ]
                [ tabContent context tab ]
    in
    div []
        [ ul [ class "tab-nav" ] (allTabs |> List.map tabButton)
        , div [ class "tab-content" ] (allTabs |> List.map tabPane)
        ]
