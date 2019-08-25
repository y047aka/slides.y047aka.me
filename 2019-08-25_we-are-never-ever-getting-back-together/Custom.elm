module Custom exposing (Content, Model, Msg, Slide, lack, mapbox, subscriptions, update, view)

import Custom.Lack as Lack
import Custom.Mapbox as Mapbox
import Html exposing (Html)
import SliceShow.Content as Content
import SliceShow.Slide as Slide


type alias Content =
    Content.Content Model Msg


type alias Slide =
    Slide.Slide Model Msg


type Model
    = LackModel Lack.Model
    | MapboxModel Mapbox.Model


type Msg
    = LackMsg Lack.Msg
    | MapboxMsg Mapbox.Msg


lack : Lack.Options -> Content
lack options =
    Content.custom (LackModel (Lack.initial options))


mapbox : Mapbox.Options -> Content
mapbox options =
    Content.custom (MapboxModel (Mapbox.initial options))


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        LackModel submodel ->
            Sub.map LackMsg (Lack.subscriptions submodel)

        MapboxModel submodel ->
            Sub.map MapboxMsg (Mapbox.subscriptions submodel)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case ( action, model ) of
        ( LackMsg a, LackModel m ) ->
            let
                ( newModel, newCmd ) =
                    Lack.update a m
            in
            ( LackModel newModel, Cmd.map LackMsg newCmd )

        ( MapboxMsg a, MapboxModel m ) ->
            let
                ( newModel, newCmd ) =
                    Mapbox.update a m
            in
            ( MapboxModel newModel, Cmd.map MapboxMsg newCmd )

        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        LackModel submodel ->
            Html.map LackMsg (Lack.view submodel)

        MapboxModel submodel ->
            Html.map MapboxMsg (Mapbox.view submodel)
