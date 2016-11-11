import Html exposing (..)
import Html.Attributes exposing (style)
import Markdown
import Html.App as App
import Step5.Steps as Steps exposing (Steps)
import Keyboard

titleSlide = """

# Lunch-dragning om Elm

Johan Strand

2016-11-15

"""

introElm = """

# Elm
* Bla
* Bla

"""

typesInElm = """

# Types in Elm
* Bla bla
* asdf

"""

type alias Slide = String

type alias Model =
  { slides: Steps Slide
  }

defaultModel =
  Model (Steps.new titleSlide [introElm, typesInElm])

type Msg =
    Noop
  | Next
  | Previous

update msg model = 
  case msg of
    Next ->
      ({ model | slides = Steps.next model.slides }, Cmd.none)
    Previous ->
      ({ model | slides = Steps.previous model.slides }, Cmd.none)
    Noop ->
      (model, Cmd.none)

slideStyles = style 
  [ ("width", "40em")
  , ("margin", "auto")
  , ("margin-top", "4em")
  , ("font-family", "Helvetica")
  , ("font-size", "18pt")
  ]

showCurrentSlide model = Markdown.toHtml [slideStyles] <| model.slides.current

view model = showCurrentSlide model

keyToMsg code =
  case code of
    39 -> Next
    37 -> Previous
    _  -> Noop

subs model = Keyboard.presses keyToMsg

main =
  App.program
    { init = defaultModel ! []
    , view = view
    , update = update
    , subscriptions = subs
    }


