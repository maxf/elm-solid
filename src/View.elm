module View exposing (view)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Update exposing (LogIn, LogOut)

view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.webId of
                "" ->
                    [ button [ onClick LogIn ] [ text "Log in" ] ]

                _ ->
                    [ text ("Logged in as " ++ (model.username |> Maybe.withDefault ""))
                    , button [ onClick LogOut ] [ text "Log out " ]
                    ]
    in
        div [] userInfo
