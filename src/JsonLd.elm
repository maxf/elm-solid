module JsonLd exposing (..)

import Json.Decode exposing (string, list, dict, oneOf, decodeString, Decoder)
import Dict exposing (..)
import Tuple exposing (first, second)


-- terminology:
-- a triple is: ( subject, predicate, object )
-- a property is a pair ( predicate, [objects] )
-- a JsonLd is a list of property dictionaries


type alias Predicate = String
type alias Subject = String
type alias Object = String

type alias JsonLd =
    List PropertyDict

type alias PropertyDict =
    Dict Predicate (List Object)


objects : Decoder (List Object)
objects =
    oneOf
        [ string |> Json.Decode.map (\s -> [ s ])
        , list string
        ]

property : Decoder PropertyDict
property =
    dict objects


fromString : String -> JsonLd
fromString json =
    case decodeString (list property) json of
        Ok result ->
            result
        Err message ->
            Debug.log ("Failed to parse JsonLD: " ++ message) []


-- after decoding the json we have a structure as
-- JsonLd = [ dict1, dict2, dict3 ]
-- dict1 = { predicate1: [ object1, object2 ], predicate2: [ object3 ], "@id": [ subject ] }



-- functions below convert a JsonLd to a List Triples

type alias Url =
    String


type alias Triple =
    { subject : Url
    , predicate : Url
    , object : String
    }


propertyToTriples : Subject -> ( Predicate, List Object ) -> List Triple
propertyToTriples subject ( predicate, objects ) =
    List.map
        (\object -> Triple subject predicate object)
        objects


-- Example:
--  dict1 = { predicate1: [ object1, object2 ], predicate2: [ object3 ], "@id": [ subject ] }
-- [ (subject, predicate1, object1 ), (subject, predicate1, object2 ), (subject...

dictToTriples : PropertyDict -> List Triple
dictToTriples dict =
    let
        maybeSubject : Maybe (List Url)
        maybeSubject =
            get "@id" dict
    in
        case maybeSubject of
            Nothing ->
                Debug.log "Failed to find @id in JSON-LD object" []

            Just [ subject ] ->
                -- now we decode all the other fields in the dict
                dict
                    |> Dict.toList
                    |> List.filter (\i -> first i /= "@id")
                    |> List.map (propertyToTriples subject)
                    |> List.concat

            Just _ ->
                Debug.log "Found multiple @id in JSON-LD object" []


jsonToTriples : String -> List Triple
jsonToTriples json =
    fromString json
        |> List.map dictToTriples
        |> List.concat
