module Model exposing (Model, initialModel)

import Auth exposing (AuthInfo)


type alias Model =
    { authInfo: Maybe AuthInfo
    , username : Maybe String
    }


initialModel : Model
initialModel =
    Model Nothing Nothing
