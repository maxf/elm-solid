module Model exposing (Model, Status(..), initialModel)

import Auth exposing (AuthInfo)
import Photos exposing (Album)
import Http

type Status
    = NoError
    | HttpError Http.Error


type alias Model =
    { authInfo: Maybe AuthInfo
    , username : Maybe String
    , userDataUrl : Maybe String
    , album: Album
    , status: Status
    }


initialModel : Model
initialModel =
    Model Nothing Nothing Nothing (Album "Empty" []) NoError
