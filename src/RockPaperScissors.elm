module RockPaperScissors exposing (..)


import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Html.Attributes exposing (classList, class)
import Html.Attributes exposing (attribute)
import Html.Attributes exposing (disabled)
import List exposing (concat)
import Random exposing(..)


import Components.RpsState exposing(..)
import Components.ViewComponents exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let 
        _ = Debug.log "op1:" model.p1_opt
        _ = Debug.log "op2:" (String.fromInt model.p2_opt_num)
    in
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

            ResetGame ->
                (
                    {
                        model | p1_opt = ""
                        , p2_opt = ""
                    },
                    Cmd.none
                )

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
        , viewReplayOptions model
        , viewOptionControls model
        ]