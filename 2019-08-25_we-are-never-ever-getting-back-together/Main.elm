module Main exposing (main)

import Custom exposing (Content, Msg)
import Formatting exposing (background, bullet, bulletLink, bullets, code, color, colored, group, noPointerEvents, padded, position, spacer, text_, title)
import Html exposing (br, h1, img, span, text)
import Html.Attributes exposing (src, style)
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
    , ports
    , hope

    -- , weAreNeverEverGettingBackTogether
    , elmPackages
    , visualization
    , jackhp95_mapbox
    , gampleman_mapbox
    , webGL
    , planning
    , fin
    ]


cover : List Content
cover =
    [ background "assets/images/cover.jpg"
        [ item
            (h1 [ style "font-size" "7rem" ]
                [ text "私たちは絶対に絶対に"
                , br [] []
                , text "Ports を頼ったりしない"
                ]
            )
        , spacer 80
        , item
            (img
                [ src "assets/images/y047aka.png"
                , style "width" "90px"
                , style "border-radius" "50%"
                ]
                []
            )
        , item
            (span
                [ style "position" "relative"
                , style "top" "-2.5rem"
                , style "padding-left" "0.5em"
                , style "font-size" "5rem"
                ]
                [ text "y047aka" ]
            )
        , spacer 20
        , text_ "Elm Meetup in Summer"
        , spacer 10
        , text_ "2019.08.25, Tokyo"
        ]
    ]


selfIntroduce : List Content
selfIntroduce =
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
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
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ title "JavaScript のライブラリ"
        , bullets
            [ bullet "データ可視化 → D3.js"
            , bullet "地図 → Leaflet.js, Mapbox GL JS"
            , bullet "WebGL / 3DCG → Three.js"
            ]
        ]
    ]


ports : List Content
ports =
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ spacer 40
        , item
            (span [ style "font-size" "5rem" ] [ text "Ports を使うと" ])
        , spacer 0
        , item
            (span [ style "font-size" "5rem" ] [ text "JavaScript の資産を活用できる" ])
        , spacer 80
        , item
            (span [ style "font-size" "3rem" ] [ text "例：ElmからJavaScriptにデータを送信する場合" ])
        , spacer 20
        , code """const app = Elm.Main.init();

app.ports.cache.subscribe((data) => {
  localStorage.setItem('cache', JSON.stringify(data));
});
"""
        ]
    ]


hope : List Content
hope =
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ spacer 200
        , item
            (span [ style "font-size" "5rem" ] [ text "でも..." ])
        , spacer 0
        , item
            (span [ style "font-size" "5rem" ] [ text "Elm だけで成立させたい！" ])
        ]
    ]


weAreNeverEverGettingBackTogether : List Content
weAreNeverEverGettingBackTogether =
    [ background "assets/images/we-are-never-ever-getting-back-together_dark.jpg"
        [ spacer 100
        , item
            (h1 [ style "font-size" "9rem" ]
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
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
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
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ title "gampleman/elm-visualization"
        , bullets
            [ bullet "SVGやCanvasのパッケージと組み合わせて使用する"
            , bullet "D3.js の知識があると、スムーズに使うことができる"
            ]
        ]
    ]


jackhp95_mapbox : List Content
jackhp95_mapbox =
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ title "jackhp95/elm-mapbox"
        , bullets
            [ bullet "Ports を使わずに、地図タイルを取得・表示する"
            , bullet "バイナリベクトルタイルには対応していない"
            ]
        ]
    ]


gampleman_mapbox : List Content
gampleman_mapbox =
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
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
    [ colored "#F6F6F6"
        "hsl(40, 60%, 45%)"
        [ title "elm-explorations/webgl"
        , bullets
            [ bullet "Three.js とは異なり、WebGL を直接操作する"
            , bullet "Elmでここだけの [glsl | ... |] という記法がある"
            , bullet "GLSLの知識が少し必要です"
            ]
        ]
    ]


planning : List Content
planning =
    [ colored ""
        "#FFF"
        [ Custom.lack { width = 1280, height = 720 } |> position 0 0
        , [ title "次のイベントを計画中です"
          , text_ "日程："
          , spacer 0
          , text_ "\u{3000}2019年 12月 7日"
          , spacer 25
          , text_ "会場："
          , spacer 0
          , text_ "\u{3000}未定（募集中）"
          , spacer 25
          , text_ "ゲスト："
          , spacer 0
          , text_ "\u{3000}Andrey Kuzmin（elm-physics, elm-slice-show）"
          ]
            |> group 100 25 1100 280
            |> noPointerEvents
        ]
    ]


fin : List Content
fin =
    [ background "assets/images/stickers.png"
        [ title "Fin."
        , spacer 350
        , text_ "会場でステッカーを配布しています"
        ]
    ]
