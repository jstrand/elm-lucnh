import Html exposing (..)
import Html.Attributes exposing (style)
import Markdown

titleSlide = """

# Lunch-dragning om Elm

Johan Strand

2016-11-15

"""

slideStyles = style [
    ("width", "40em")
  , ("margin", "auto")
  , ("margin-top", "4em")
  , ("font-family", "Helvetica")
  , ("font-size", "18pt")
  ]

main = Markdown.toHtml [slideStyles] titleSlide

