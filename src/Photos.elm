module Photos exposing (Album, albumDecoder, fetchAlbum)

import Http
import Json.Decode exposing (Decoder, list, string, succeed)
import Json.Decode.Pipeline exposing (requiredAt)
import Types exposing (..)


type alias Album =
    { title : String
    , photos : List Url
    }


albumDecoder : Decoder Album
albumDecoder =
    succeed Album
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
