module RockPaperScissors exposing (..)


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Main2 exposing (Model)
import Main2 exposing (Msg(..))
import Html.Attributes exposing (style)
import Html.Attributes exposing (classList, class)
import List exposing (concat)
import Random exposing(..)
import Html.Attributes exposing (attribute)
import Html.Attributes exposing (disabled)

--#region Main
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
--#endregion
type alias RpsState =
    { result : String
    , p1_opt : String
    , p2_opt : String 
    , p2_opt_num: Int
    }

type alias Model = RpsState
init: () -> (Model, Cmd Msg)
init _ =
    (
        {
            result = "---"
            ,p1_opt = ""
            ,p2_opt = ""
            ,p2_opt_num = 0
        }
        , Cmd.none
    )


p2SelectOpt : Int -> String
p2SelectOpt p2_opt =
    case p2_opt of
        1 -> 
            "Rock"
        2 ->
            "Paper"
        3 -> 
            "Scissors"
        _ -> 
            "Paper"
botOptAreEquals : String -> String -> Bool
botOptAreEquals p1_opt p2_opt =
    if p1_opt == p2_opt then
        True
    else
        False

calcResults : String -> String -> String
calcResults p1_opt p2_opt = 
    let 
        _ = Debug.log "foo is" (p1_opt++"_"++p2_opt)
    in
    if (botOptAreEquals p1_opt p2_opt) then
        "Nobody"
    else
        case (p1_opt++"_"++p2_opt) of
            "Paper_Scissors" ->
                "You Loose!"
            "Scissors_Paper" ->
                "You Win!"
            "Scissors_Rock" ->
                "You Loose!"
            "Rock_Scissors" ->
                "You Win!"
            "Rock_Paper" ->
                "You Loose!"
            "Paper_Rock" ->
                "You Win!"
            _ ->
                "Na"
type Msg = 
    PlayGame String
    | NewFace Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        PlayGame p1_opt ->
            ( {model | p1_opt = p1_opt}
            , Random.generate NewFace (Random.int 1 3)
            )

        NewFace newFace ->
            (
                {
                    model | p2_opt_num = newFace
                    , p2_opt = p2SelectOpt model.p2_opt_num
                },
                Cmd.none
            )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
view : Model -> Html Msg
view model =
    div
        [ class "rock-paper-scissors"]
        [ div
            [ class "rock-paper-scissors__display"]
            [ viewPlayerSelection model
            , viewValidation model
            ]
        , viewOptionControls model
        ]


viewOptionControls: Model -> Html Msg
viewOptionControls model =
    if model.p1_opt == "" then
        div [ class "rock-paper-scissors__options"]
        [
            viewOptButton model "Rock" False
            ,viewOptButton model "Paper" False
            ,viewOptButton model "Scissors" False
        ]
    else
        div [ class "rock-paper-scissors__options"]
        [
            viewOptButton model "Rock" True
            ,viewOptButton model "Paper" True
            ,viewOptButton model "Scissors" True
        ]


viewOptButton: Model -> String -> Bool -> Html Msg
viewOptButton model opt_txt disabled =
    if disabled == False then
        button [ 
            classList [
                ("active", model.p1_opt == opt_txt)
                ,("animate__animated animate__flash", model.p1_opt == opt_txt)
            ]
            ,onClick (PlayGame opt_txt)
        ]
        [ text opt_txt ]
    else
        button [ 
            classList [
                ("active", model.p1_opt == opt_txt)
                ,("animate__animated animate__flash", model.p1_opt == opt_txt)
            ],
            attribute "disabled" "" 
            ,onClick (PlayGame opt_txt)
        ]
        [ text opt_txt ]
viewPlayerSelection: Model -> Html msg
viewPlayerSelection model =
    if model.p1_opt == "" || model.p1_opt == "" then
            text ("")
    else
        div
            [ 
                class "adversary-option"
            ]
            [   div[][ text(model.p1_opt) ]
                ,div[][ text("vs") ]
                ,div[][ text(model.p2_opt) ]
                
            ]

viewValidation : Model -> Html msg
viewValidation model =
    let
        result: String
        result = calcResults model.p1_opt model.p2_opt
    in
    
        if model.p1_opt == "" || model.p1_opt == "" then
            text ("")
        else
            div
                    [ 
                        classList[
                            ("game-result", True)
                            ,("animate__animated", True)
                            ,("animate__bounce", result == "You Win!")
                            ,("animate__headShake", result == "You Loose!")
                            ,("animate__heartBeat", result == "Nobody")

                        ]
                    ]
                    [ 
                        text (calcResults model.p1_opt model.p2_opt)
                    ]