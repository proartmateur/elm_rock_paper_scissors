module Main3 exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Main2 exposing (Model)
import Main2 exposing (Msg(..))
import Html.Attributes exposing (style)
import Html.Attributes exposing (classList)

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

type alias Model = Int
init: Model
init = 0

type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 2

        Decrement ->
            model - 1

view : Model -> Html Msg
view model =
    div [
        style "border" "1px solid red"
        ,style "display" "flex"
        ,style "padding" "10px 20px"
    ]
    [

        div[
            classList [
                ("notice", True)
            ]
        ] 
        [ 
            button [onClick Decrement][text "-"]
            ,text (String.fromInt model) 
            ,button [onClick Increment][text "+"]
        ]
    ]


div [ class "rock-paper-scissors__options"]
            [ 
                button [ 
                    classList [
                        ("active", model.p1_opt == "Rock")
                        ,("animate__animated animate__flash", model.p1_opt == "Rock")
                    ]
                    ,onClick (PlayGame "Rock")
                ]
                [ text "Rock" ]
            , button
                [ 
                    classList [
                        ("active", model.p1_opt == "Paper")
                        ,("animate__animated animate__flash", model.p1_opt == "Paper")
                    ]
                    ,onClick (PlayGame "Paper")
                ]
                [ text "Paper" ]
            , button [
                    classList [
                            ("active", model.p1_opt == "Scissors")
                            ,("animate__animated animate__flash", model.p1_opt == "Scissors")
                    ]
                    ,onClick (PlayGame "Scissors")
                    ]
                [ text "Scissors" ]
            ]