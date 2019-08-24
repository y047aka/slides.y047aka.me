module Main exposing (main)

import Custom exposing (Content, Msg)
import Formatting exposing (background, bullet, bulletLink, bullets, colored, group, noPointerEvents, padded, position, spacer, text_, title)
import Html exposing (br, h1, text)
import Html.Attributes exposing (style)
import SliceShow exposing (Message, Model, init, setSubscriptions, setUpdate, setView, show)
import SliceShow.Content exposing (item)
import SliceShow.Slide exposing (setDimensions, slide)


main : Program () (Model Custom.Model Msg) (Message Msg)
main =
    slides
        |> List.map (slide >> setDimensions ( 1280, 720 ))
        |> init
        |> setSubscriptions Custom.subscriptions
        |> setView Custom.view
        |> setUpdate Custom.update
        |> show


slides =
    [ cover
    , selfIntroduce
    , jsLibraries
    , request

    -- , weAreNeverEverGettingBackTogether
    , elmPackages
    , visualization
    , jackhp95_mapbox
    , gampleman_mapbox
    , webGL
    ]


cover : List Content
cover =
    [ colored ""
        "#FFF"
        [ Custom.lack { width = 1280, height = 720 } |> position 0 0
        , [ item
                (h1 [ style "font-size" "4.5rem" ]
                    [ text "私たちは絶対に絶対に"
                    , br [] []
                    , text "Ports を頼ったりしない"
                    ]
                )
          , text_ "Elm Meetup in Summer"
          , spacer 100
          , text_ "Yoshitaka Totsuka"
          ]
            |> group 100 50 700 280
            |> noPointerEvents
        ]
    ]


selfIntroduce : List Content
selfIntroduce =
    [ padded
        [ title "自己紹介"
        , bullets
            [ bullet "2017年10月に建築業界から転職しました"
            , bullet "2019年2月から Elm を使っています"
            , bulletLink "elm-starfighter" "https://github.com/y047aka/elm-starfighter"
            , bulletLink "ElmJapanLogoGenerator" "https://y047aka.github.io/elm-japan-logo-generator/"
            ]
        ]
    ]


jsLibraries : List Content
jsLibraries =
    [ padded
        [ title "JavaScript のライブラリ"
        , bullets
            [ bullet "データ可視化 → D3.js"
            , bullet "地図 → Leaflet.js, Mapbox GL JS"
            , bullet "WebGL / 3DCG → Three.js"
            ]
        ]
    ]


request : List Content
request =
    [ padded
        [ spacer 80
        , text_ "Ports を使うと"
        , spacer 0
        , text_ "JavaScript の資産を活用できる"
        , spacer 130
        , text_ "でも..."
        , spacer 0
        , text_ "Elm だけで成立させたい！"
        ]
    ]


weAreNeverEverGettingBackTogether : List Content
weAreNeverEverGettingBackTogether =
    [ background "assets/images/we-are-never-ever-getting-back-together_dark.jpg"
        [ item
            (h1 [ style "font-size" "9.5rem" ]
                [ text "We Are Never Ever"
                , br [] []
                , text "Getting Back Together"
                ]
            )
        , text_ "私たちは絶対に絶対に"
        , spacer 0
        , text_ "Ports を頼ったりしない！"
        ]
    ]


elmPackages : List Content
elmPackages =
    [ padded
        [ title "Elm packages"
        , bullets
            [ bullet "gampleman/elm-visualization"
            , bullet "jackhp95/elm-mapbox , gampleman/elm-mapbox"
            , bullet "elm-explorations/webgl , w0rm/elm-physics"
            ]
        ]
    ]


visualization : List Content
visualization =
    [ padded
        [ title "gampleman/elm-visualization"
        , bullets
            [ bullet "SVGやCanvasのパッケージと組み合わせて使用する"
            , bullet "D3.js の知識があると、スムーズに使うことができる"
            ]
        ]
    ]


jackhp95_mapbox : List Content
jackhp95_mapbox =
    [ padded
        [ title "jackhp95/elm-mapbox"
        , bullets
            [ bullet "Ports を使わずに、地図タイルを取得・表示する"
            , bullet "バイナリベクトルタイルには対応していない"
            ]
        ]
    ]


gampleman_mapbox : List Content
gampleman_mapbox =
    [ padded
        [ title "gampleman/elm-mapbox"
        , bullets
            [ bullet "Ports を使う（npmで配布されている）"
            , bullet "Mapbox GL JS をラップしている"
            , bullet "バイナリベクトルタイルに対応している！"
            ]
        ]
    ]


webGL : List Content
webGL =
    [ padded
        [ title "elm-explorations/webgl"
        , bullets
            [ bullet "Three.js とは異なり、WebGL を直接操作する"
            , bullet "Elmでここだけの [glsl | ... |] という記法がある"
            , bullet "GLSLの知識が少し必要です"
            ]
        ]
    ]
