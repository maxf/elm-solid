module Model exposing (Model, Status(..), initialModel)

import Auth exposing (AuthInfo)
import Browser.Navigation as Nav
import Http
import Photos exposing (Album)
import Url


type Status
    = NoError
    | HttpError Http.Error


type alias Model =
    { authInfo : Maybe AuthInfo
    , username : Maybe String
    , userDataUrl : Maybe String
    , album : Album
    , status : Status
    , key : Nav.Key
    , url : Url.Url
    }


initialModel : Url.Url -> Nav.Key -> Model
initialModel url key =
    Model Nothing Nothing Nothing (Album "Empty" []) NoError key url
