module Custom exposing (Content, Model, Msg, subscriptions, update, view)

import Html exposing (Html)
import SliceShow.Content as Content


type alias Content =
    Content.Content Model Msg


type alias Model =
    {}


type Msg
    = NoOp


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] []
