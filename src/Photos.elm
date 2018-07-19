module Photos exposing (..)

import Types exposing (..)
import Json.Decode exposing (string, list, Decoder)
import Json.Decode.Pipeline exposing (decode, requiredAt)
import Http

type alias Album =
    { title : String
    , photos : List Url
    }


albumDecoder : Decoder Album
albumDecoder =
    decode Album
        |> requiredAt [ "title" ] string
        |> requiredAt [ "photos" ] (list string)


fetchAlbum : Url -> (Result Http.Error Album -> msg) -> Cmd msg
fetchAlbum albumUrl returnMsg =
    let
        request : Http.Request Album
        request =
            Http.get
                (albumUrl ++ "public/apps/elm-solid/photos.json")
                albumDecoder
    in
        Http.send returnMsg request
