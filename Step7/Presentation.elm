import Html exposing (..)
import Html.Attributes exposing (style, value)
import Html.Events exposing (onClick, onInput)
import Markdown
import Html.App as App
import Step7.Steps as Steps exposing (Steps)
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
type Mode = Presenting | Editing

type alias Model =
  { slides: Steps Slide
  , mode: Mode
  , editBuffer: String
  }

defaultModel =
  Model (Steps.new titleSlide [introElm, typesInElm]) Presenting ""

type Msg =
    Noop
  | Next
  | Previous
  | Edit
  | Change String
  | Save
  | Cancel

update msg model = 
  case msg of
    Change newContent ->
      ({ model | editBuffer = newContent }, Cmd.none)
    Edit ->
      ({ model | mode = Editing, editBuffer = model.slides.current }, Cmd.none)
    Save ->
      ({ model | mode = Presenting, slides = Steps.set model.slides model.editBuffer }, Cmd.none)
    Cancel ->
      ({ model | mode = Presenting, editBuffer = "" }, Cmd.none)
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

editStyles = 
  [ ("width", "100%")
  , ("height", "20em")
  ] ++ previewStyles

editContainerStyles = style
  [ ("margin", "auto")
  , ("width", "40em")
  , ("margin-top", "4em")
  ]

previewStyles =
  [ ("font-family", "Helvetica")
  , ("font-size", "12pt")
  ]

saveButton = button [onClick Save] [text "Spara"]

cancelButton = button [onClick Cancel] [text "Avbryt"]

showSlideEdit model =
  div [editContainerStyles]
    [ textarea [style editStyles, value model.editBuffer, onInput Change] []
    , div [] [saveButton, cancelButton]
    , Markdown.toHtml [style previewStyles] <| model.editBuffer
    ]

view model =
  case model.mode of
    Editing -> showSlideEdit model
    Presenting -> showCurrentSlide model

keyToMsg code =
  case code of
    39 -> Next
    37 -> Previous
    13 -> Edit
    _  -> Noop

subs model = 
  case model.mode of
    Presenting -> Keyboard.presses keyToMsg
    Editing -> Sub.none

main =
  App.program
    { init = defaultModel ! []
    , view = view
    , update = update
    , subscriptions = subs
    }


