import Html exposing (Html)
import Html.App as App
import Time exposing (Time, second)
import AnimationFrame
import Animation exposing (..)
import Collage exposing (..)
import Color
import Element exposing (toHtml)

onCircle radius angle = (radius * (cos angle), radius * (sin angle))

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
  { current: Time
  , end: Time
  , balls: Int
  }

init : (Model, Cmd Msg)
init =
  (Model 0 0 0, Cmd.none)

type Msg
  = Tick Time

delay = 5

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      let endTime = newTime + delay*Time.minute
          balls = floor <| Time.inSeconds <| endTime - newTime
      in
      if model.current == 0 then (Model newTime endTime balls, Cmd.none)
      else ({model | current = newTime}, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  AnimationFrame.times Tick

color x = if (floor x) % 60 == 0 then Color.red else Color.blue

ball end current x = 
  let
    x' = toFloat x
    pos = onCircle x' (degrees (8*x'))
    start = end - x'*Time.second
    ballSize = animation start |> from 10 |> to 0 |> duration (4*second)
    radius = animate current ballSize
  in
    move pos <| filled (color x') <| circle radius

view model =
  if model.current == 0 then Html.text "..."
  else toHtml <| collage 1024 1024 (List.map (ball model.end model.current) [0..model.balls])

