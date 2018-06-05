module Model exposing (Model, initialModel)


type alias Model =
    { webId : String -- empty string means no user is logged in
    , username : Maybe String
    }


initialModel : Model
initialModel =
    Model "" Nothing
