module Custom exposing (Content, Model, Msg, Slide, lack, subscriptions, update, view)

import Custom.Lack as Lack
import Html exposing (Html)
import SliceShow.Content as Content
import SliceShow.Slide as Slide


type alias Content =
    Content.Content Model Msg


type alias Slide =
    Slide.Slide Model Msg


type Model
    = LackModel Lack.Model


type Msg
    = LackMsg Lack.Msg


lack : Lack.Options -> Content
lack options =
    Content.custom (LackModel (Lack.initial options))


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        LackModel submodel ->
            Sub.map LackMsg (Lack.subscriptions submodel)


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case ( action, model ) of
        ( LackMsg a, LackModel m ) ->
            let
                ( newModel, newCmd ) =
                    Lack.update a m
            in
            ( LackModel newModel, Cmd.map LackMsg newCmd )


view : Model -> Html Msg
view model =
    case model of
        LackModel submodel ->
            Html.map LackMsg (Lack.view submodel)
