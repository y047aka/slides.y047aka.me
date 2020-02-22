module Custom.Mapbox exposing
    ( Model
    , Msg
    , Options
    , initial
    , subscriptions
    , update
    , view
    )

import Browser
import Common.MapCommands as MapCommands
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Json.Decode
import Json.Encode
import LngLat exposing (LngLat)
import Mapbox.Cmd.Option as Opt
import Mapbox.Element exposing (EventData, MapboxAttr, css, eventFeaturesLayers, featureState, id, map, maxZoom, onClick, onMouseMove, token)
import Mapbox.Expression as E exposing (false, float, int, str, true)
import Mapbox.Layer as Layer
import Mapbox.Source as Source
import Mapbox.Style as Style exposing (Style(..), light)


type alias Options =
    { width : Float
    , height : Float
    }



-- MODEL


type alias Model =
    { position : LngLat
    , features : List Json.Encode.Value
    }


initial : Options -> Model
initial { width, height } =
    { position = LngLat 0 0
    , features = []
    }



-- UPDATE


type Msg
    = Hover EventData
    | Click EventData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Hover { lngLat, renderedFeatures } ->
            ( { model | position = lngLat, features = renderedFeatures }, Cmd.none )

        Click { lngLat, renderedFeatures } ->
            ( { model | position = lngLat, features = renderedFeatures }, MapCommands.fitBounds [ Opt.linear True, Opt.maxZoom 10 ] ( LngLat.map (\a -> a - 0.2) lngLat, LngLat.map (\a -> a + 0.2) lngLat ) )


geojson =
    Json.Decode.decodeString Json.Decode.value """
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": 1,
      "properties": {
        "name": "Bermuda Triangle",
        "area": 1150180
      },
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [-64.73, 32.31],
            [-80.19, 25.76],
            [-66.09, 18.43],
            [-64.73, 32.31]
          ]
        ]
      }
    }
  ]
}
""" |> Result.withDefault (Json.Encode.object [])


hoveredFeatures : List Json.Encode.Value -> MapboxAttr msg
hoveredFeatures =
    List.map (\feat -> ( feat, [ ( "hover", Json.Encode.bool True ) ] ))
        >> featureState



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    let
        sources =
            [ Source.vectorFromUrl "composite" "mapbox://mapbox.mapbox-terrain-v2,mapbox.mapbox-streets-v7"
            , Source.raster "m_mono" [ "https://tile.mierune.co.jp/mierune_mono/{z}/{x}/{y}.png" ] []
            , Source.geoJSONFromValue "changes" [] geojson
            ]

        misc =
            [ Style.name "light"
            , Style.defaultCenter <| LngLat 140.0 38.0
            , Style.defaultZoomLevel 5.0
            , Style.sprite "mapbox://sprites/mapbox/streets-v7"
            , Style.glyphs "mapbox://fonts/mapbox/{fontstack}/{range}.pbf"
            ]

        layers =
            [ Layer.background "background"
                [ E.rgba 246 246 244 1 |> Layer.backgroundColor
                ]

            -- , Layer.fill "landcover"
            --     "composite"
            --     [ Layer.sourceLayer "landcover"
            --     , E.any
            --         [ E.getProperty (str "class") |> E.isEqual (str "wood")
            --         , E.getProperty (str "class") |> E.isEqual (str "scrub")
            --         , E.getProperty (str "class") |> E.isEqual (str "grass")
            --         , E.getProperty (str "class") |> E.isEqual (str "crop")
            --         ]
            --         |> Layer.filter
            --     , Layer.fillColor (E.rgba 227 227 227 1)
            --     , Layer.fillOpacity (float 0.6)
            --     ]
            , Layer.raster "mierune_mono"
                "m_mono"
                [ Layer.minzoom 0
                , Layer.maxzoom 14
                ]
            , Layer.symbol "place-city-lg-n"
                "composite"
                [ Layer.sourceLayer "place_label"
                , Layer.minzoom 1
                , Layer.maxzoom 14
                , Layer.filter <|
                    E.all
                        [ E.getProperty (str "scalerank") |> E.greaterThan (int 2)
                        , E.getProperty (str "type") |> E.isEqual (str "city")
                        ]
                , Layer.textField <|
                    E.format
                        [ E.getProperty (str "name_en")
                            |> E.formatted
                            |> E.fontScaledBy (float 1.2)
                        , E.formatted (str "\n")
                        , E.getProperty (str "name")
                            |> E.formatted
                            |> E.fontScaledBy (float 0.8)
                            |> E.withFont (E.strings [ "DIN Offc Pro Medium" ])
                        ]
                , Layer.textTransform <| E.ifElse (E.getProperty (str "name_en") |> E.isEqual (str "Vienna")) E.uppercase E.none
                ]
            , Layer.fill "changes"
                "changes"
                [ Layer.fillOpacity (E.ifElse (E.toBool (E.featureState (str "hover"))) (float 0.9) (float 0.1))
                ]
            ]
    in
    div []
        [ css
        , div [ style "width" "1280px", style "height" "720px" ]
            [ map
                [ token "pk.eyJ1IjoieTA0N2FrYSIsImEiOiJjanlyZ3ZvNDUwYjJvM210a2F0bGV0dm82In0.gumWKg-JXwJQTFiF3S7KfQ"
                , maxZoom 18
                , onMouseMove Hover
                , onClick Click
                , id "my-map"
                , eventFeaturesLayers [ "changes" ]
                , hoveredFeatures model.features
                ]
                -- (Style
                --     { transition = Style.defaultTransition
                --     , light = Style.defaultLight
                --     , sources = sources
                --     , misc = misc
                --     , layers = layers
                --     }
                -- )
                Style.light
            , div [ style "position" "absolute", style "bottom" "20px", style "left" "20px" ] [ text (LngLat.toString model.position) ]
            ]
        ]
