module Architecture.Init exposing (extractWith, fromRoute, init)

import Architecture.Model exposing (..)
import Architecture.Msg exposing (..)
import Architecture.Route as Route exposing (Route)
import Browser.Navigation as Navigation exposing (Key)
import Page.Home as Home
import Page.NotFound as NotFound
import Types.Session exposing (Session)
import Url exposing (Url)


init : () -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    Route.fromUrl url
        |> (\route -> fromRoute route {})


extractWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
extractWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel, Cmd.map toMsg subCmd )


fromRoute : Route -> Session -> ( Model, Cmd Msg )
fromRoute route session =
    case route of
        Route.Home ->
            Home.init session
                |> extractWith Home GotHomeMsg

        Route.NotFound ->
            NotFound.init session
                |> extractWith NotFound GotNotFoundMsg
