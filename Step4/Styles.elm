module Styles exposing (..)
import Css
import Html exposing (..)
import Html.Attributes exposing (..)

type Id = MyId
type Class = MyClass

-- import some google fonts
imports =
    ["https://fonts.googleapis.com/css?family=Droid+Sans:400,700"
    ]

-- create ruels, notice the use of MyId and MyClass. 
rules =
    [ { selectors = [ Css.Id MyId ]
      , descriptor = [ ("color", "red"), ("font-family", "Droid Sans") ]
      }
    , { selectors = [ Css.Class MyClass ]
      , descriptor = [ ("color", "blue") ]
      }
    , { selectors = [ Css.Type "div" ]
      , descriptor = [("font-family", "Droid Sans"), ("margin", "auto")] }
    ]

-- compile a stylesheet with imports and a single rule
stylesheet = Css.stylesheet imports rules

-- now, add the style node, and safely use your ids and classes
main =
    div [ style [("width", "100%")] ]
        [ Css.style [scoped True] stylesheet
        , div [ style [("width", "100px")], stylesheet.id MyId ] [ text "Using MyId" ]
        , div [ stylesheet.class MyClass ] [ text "Using MyClass" ]
        ]
