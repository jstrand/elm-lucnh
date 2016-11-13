import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Task



main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { contents : String
  }


init : (Model, Cmd Msg)
init =
  ( Model "loading"
  , getRandomGif
  )



-- UPDATE


type Msg
  = MorePlease
  | FetchSucceed String
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif)

    FetchSucceed data ->
      (Model model.contents, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.contents]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getRandomGif : Cmd Msg
getRandomGif =
  let
    url =
      --"http://api.zippopotam.us/us/90210"
      "http://localhost:5000/"
  in
    Task.perform FetchFail FetchSucceed (Http.getString url)


decodeGifUrl : Json.Decoder (List String)
decodeGifUrl =
  Json.list Json.string
