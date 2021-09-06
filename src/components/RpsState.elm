module Components.RpsState exposing (..)

type alias RpsState =
    { result : String
    , p1_opt : String
    , p2_opt : String 
    , p2_opt_num: Int
    }

type alias Model = RpsState

type Msg = 
    PlayGame String
    | NewFace Int
    | ResetGame

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

