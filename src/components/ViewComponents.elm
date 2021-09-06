module Components.ViewComponents exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Html.Attributes exposing (classList, class)
import Html.Attributes exposing (attribute)
import Html.Attributes exposing (disabled)

import Components.RpsState exposing(..)

viewReplayOptions: Model -> Html Msg
viewReplayOptions model =
    if model.p1_opt /= "" then
        div[
            class "rock-paper-scissors__replay"
        ]
        [
            button [ 
                class "btn-replay"
                , onClick ResetGame
                ]
            [
                text "R"
            ]
        ]
    else
        div[][]
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