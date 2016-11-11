module Step6.Steps exposing (..)

import List

type alias Steps a =
  { previousSteps: List a
  , current: a
  , nextSteps: List a
  }

new : a -> List a -> Steps a 
new step nextSteps =
  { previousSteps = []
  , current = step
  , nextSteps = nextSteps    
  }

set : Steps a -> a -> Steps a
set steps step =
  { steps | current = step }

next : Steps a -> Steps a
next steps =
  let { previousSteps, current, nextSteps } = steps
  in 
  case nextSteps of
    n::rest -> { current = n, nextSteps = rest, previousSteps = current::previousSteps }
    _ -> steps


previous : Steps a -> Steps a
previous steps =
  let { previousSteps, current, nextSteps } = steps
  in 
  case previousSteps of
    n::rest -> { current = n, nextSteps = current::nextSteps, previousSteps = rest }
    _ -> steps
