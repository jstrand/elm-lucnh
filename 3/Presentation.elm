import Html exposing (..)
import Markdown

titleSlide = """

# Lunch-dragning om Elm

Johan Strand

2016-11-15

"""

main = Markdown.toHtml [] titleSlide
