module Element.Internal.Render exposing (..)

{-| -}

import Html exposing (Html)
import Html.Keyed
import Html.Attributes
import Element.Internal.Model exposing (..)
import Style.Internal.Model as Internal exposing (Length)
import Style.Internal.Render.Value as Value
import Style.Internal.Render.Property as Property
import Element.Internal.Adjustments as Adjustments


{-| A modified version of CSS normalize is used.

The unminified version lives in `references/modified-normalize.css`.

-}
normalize : String
normalize =
    """.style-elements-root article,.style-elements-root aside,.style-elements-root figcaption,.style-elements-root figure,.style-elements-root footer,.style-elements-root header,.style-elements-root main,.style-elements-root nav,.style-elements-root section{display:block}.style-elements-root a,.style-elements-root abbr,.style-elements-root acronym,.style-elements-root address,.style-elements-root applet,.style-elements-root article,.style-elements-root aside,.style-elements-root audio,.style-elements-root b,.style-elements-root big,.style-elements-root blockquote,.style-elements-root body,.style-elements-root canvas,.style-elements-root caption,.style-elements-root center,.style-elements-root cite,.style-elements-root code,.style-elements-root dd,.style-elements-root del,.style-elements-root details,.style-elements-root dfn,.style-elements-root div,.style-elements-root dl,.style-elements-root dt,.style-elements-root em,.style-elements-root embed,.style-elements-root fieldset,.style-elements-root figcaption,.style-elements-root figure,.style-elements-root footer,.style-elements-root form,.style-elements-root h1,.style-elements-root h2,.style-elements-root h3,.style-elements-root h4,.style-elements-root h5,.style-elements-root h6,.style-elements-root header,.style-elements-root hgroup,.style-elements-root hr,.style-elements-root html,.style-elements-root i,.style-elements-root iframe,.style-elements-root img,.style-elements-root ins,.style-elements-root kbd,.style-elements-root label,.style-elements-root legend,.style-elements-root li,.style-elements-root mark,.style-elements-root menu,.style-elements-root nav,.style-elements-root object,.style-elements-root ol,.style-elements-root output,.style-elements-root p,.style-elements-root pre,.style-elements-root q,.style-elements-root ruby,.style-elements-root s,.style-elements-root samp,.style-elements-root section,.style-elements-root small,.style-elements-root span,.style-elements-root strike,.style-elements-root strong,.style-elements-root sub,.style-elements-root summary,.style-elements-root sup,.style-elements-root table,.style-elements-root tbody,.style-elements-root td,.style-elements-root tfoot,.style-elements-root th,.style-elements-root thead,.style-elements-root time,.style-elements-root tr,.style-elements-root tt,.style-elements-root u,.style-elements-root ul,.style-elements-root var,.style-elements-root video{margin:0;padding:0;border:0;font:inherit}.style-elements-root html{line-height:1;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}.style-elements-root body{margin:0}.style-elements-root h1{font-size:2em;margin:.67em 0}.style-elements-root code,.style-elements-root kbd,.style-elements-root pre,.style-elements-root samp{font-family:monospace,monospace;font-size:1em}.style-elements-root figure{margin:1em 40px}.style-elements-root hr{box-sizing:content-box;height:0;overflow:visible}.style-elements-root a{background-color:transparent;-webkit-text-decoration-skip:objects}.style-elements-root abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}.style-elements-root b,.style-elements-root strong{font-weight:bolder}.style-elements-root dfn{font-style:italic}.style-elements-root mark{background-color:#ff0;color:#000}.style-elements-root small{font-size:80%}.style-elements-root sub,.style-elements-root sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}.style-elements-root sub{bottom:-.25em}.style-elements-root sup{top:-.5em}.style-elements-root audio,.style-elements-root video{display:inline-block}.style-elements-root audio:not([controls]){display:none;height:0}.style-elements-root img{border-style:none}.style-elements-root svg:not(:root){overflow:hidden}.style-elements-root button,.style-elements-root input,.style-elements-root optgroup,.style-elements-root select,.style-elements-root textarea{font-family:sans-serif;font-size:100%;margin:0}.style-elements-root button,.style-elements-root input{overflow:visible}.style-elements-root button,.style-elements-root select{text-transform:none}.style-elements-root [type=reset],.style-elements-root [type=submit],.style-elements-root button,.style-elements-root html [type=button]{-webkit-appearance:button}.style-elements-root [type=button]::-moz-focus-inner,.style-elements-root [type=reset]::-moz-focus-inner,.style-elements-root [type=submit]::-moz-focus-inner,.style-elements-root button::-moz-focus-inner{border-style:none;padding:0}.style-elements-root [type=button]:-moz-focusring,.style-elements-root [type=reset]:-moz-focusring,.style-elements-root [type=submit]:-moz-focusring,.style-elements-root button:-moz-focusring{outline:ButtonText dotted 1px}.style-elements-root fieldset{padding:.35em .75em .625em}.style-elements-root [type=checkbox],.style-elements-root [type=radio],.style-elements-root legend{box-sizing:border-box;padding:0}.style-elements-root legend{color:inherit;display:table;max-width:100%;white-space:normal}.style-elements-root progress{display:inline-block;vertical-align:baseline}.style-elements-root textarea{overflow:auto}.style-elements-root [type=number]::-webkit-inner-spin-button,.style-elements-root [type=number]::-webkit-outer-spin-button{height:auto}.style-elements-root [type=search]{-webkit-appearance:textfield;outline-offset:-2px}.style-elements-root [type=search]::-webkit-search-cancel-button,.style-elements-root [type=search]::-webkit-search-decoration{-webkit-appearance:none}.style-elements-root ::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}.style-elements-root details,.style-elements-root menu{display:block}.style-elements-root summary{display:list-item}.style-elements-root canvas{display:inline-block}.style-elements-root [hidden],.style-elements-root template{display:none}.style-elements-root em{font-style:italic}.style-elements-root strong{font-weight:700}.style-elements-root a{text-decoration:none}.style-elements-root input,.style-elements-root textarea{border:0}.style-elements-root .clearfix:after{content:"";display:table;clear:both}"""


normalizeFull : () -> String
normalizeFull _ =
    "html,body{width:100%;height:100%;}" ++ normalize


viewport : Internal.StyleSheet elem variation -> Element elem variation msg -> Html msg
viewport stylesheet elm =
    Html.div
        [ Html.Attributes.class "style-elements-root"
        , Html.Attributes.style
            [ ( "width", "100%" )
            , ( "height", "100%" )
            ]
        ]
        (embed True stylesheet :: render stylesheet elm)


root : Internal.StyleSheet elem variation -> Element elem variation msg -> Html msg
root stylesheet elm =
    Html.div [ Html.Attributes.class "style-elements-root" ]
        (embed False stylesheet :: render stylesheet elm)


embed : Bool -> Internal.StyleSheet elem variation -> Html msg
embed full stylesheet =
    Html.node "style"
        []
        [ Html.text <|
            if full then
                normalizeFull () ++ stylesheet.css
            else
                normalize ++ stylesheet.css
        ]


render : Internal.StyleSheet elem variation -> Element elem variation msg -> List (Html msg)
render stylesheet elm =
    let
        ( adjusted, onScreen ) =
            Adjustments.apply elm

        fixedScreenElements =
            case onScreen of
                Nothing ->
                    []

                Just screenEls ->
                    List.map (renderElement Nothing stylesheet FirstAndLast) screenEls
    in
        renderElement Nothing stylesheet FirstAndLast adjusted
            :: fixedScreenElements


type alias Parent =
    { parentSpecifiedSpacing : Maybe ( Float, Float, Float, Float )
    , layout : Internal.LayoutModel
    , parentPadding : ( Float, Float, Float, Float )
    }


detectOrder : List a -> number -> Order
detectOrder list i =
    let
        len =
            List.length list
    in
        if i == 0 && len == 1 then
            FirstAndLast
        else if i == 0 then
            First
        else if i == len - 1 then
            Last
        else
            Middle i


spacingToMargin : List (Attribute variation msg) -> List (Attribute variation msg)
spacingToMargin attrs =
    let
        spaceToMarg a =
            case a of
                Spacing x y ->
                    Margin ( y, x, y, x )

                a ->
                    a
    in
        List.map spaceToMarg attrs


calcPosition : Frame -> ( Maybe Float, Maybe Float, Maybe Float ) -> List ( String, String )
calcPosition frame ( mx, my, mz ) =
    let
        x =
            Maybe.withDefault 0 mx

        y =
            Maybe.withDefault 0 my

        z =
            Maybe.withDefault 0 mz
    in
        case frame of
            Relative ->
                [ ( "position", "relative" )
                , ( "left", (toString x ++ "px") )
                , ( "top", (toString y ++ "px") )
                ]

            Screen ->
                [ ( "position", "fixed" )
                , ( "left", (toString x ++ "px") )
                , ( "top", (toString y ++ "px") )
                , ( "z-index", "1000" )
                ]

            Absolute TopLeft ->
                List.filterMap identity
                    [ Just ( "position", "absolute" )
                    , case mx of
                        Just x ->
                            Just ( "left", (toString x ++ "px") )

                        Nothing ->
                            Nothing
                    , case my of
                        Just y ->
                            Just ( "top", (toString y ++ "px") )

                        Nothing ->
                            Nothing
                    ]

            Absolute BottomLeft ->
                List.filterMap identity
                    [ Just ( "position", "absolute" )
                    , case mx of
                        Just x ->
                            Just ( "left", (toString x ++ "px") )

                        Nothing ->
                            Nothing
                    , case my of
                        Just y ->
                            Just ( "bottom", (toString y ++ "px") )

                        Nothing ->
                            Nothing
                    ]

            Nearby Within ->
                [ ( "position", "relative" )
                , ( "top", (toString y ++ "px") )
                , ( "left", (toString x ++ "px") )
                ]

            Nearby Above ->
                [ ( "position", "relative" )
                , ( "top", (toString y ++ "px") )
                , ( "left", (toString x ++ "px") )
                ]

            Nearby Below ->
                [ ( "position", "relative" )
                , ( "top", ("calc(100% + " ++ toString y ++ "px)") )
                , ( "left", (toString x ++ "px") )
                ]

            Nearby OnLeft ->
                [ ( "position", "relative" )
                , ( "right", ("calc(100% - " ++ toString x ++ "px)") )
                , ( "top", (toString y ++ "px") )
                ]

            Nearby OnRight ->
                [ ( "position", "relative" )
                , ( "left", ("calc(100% + " ++ toString x ++ "px)") )
                , ( "top", (toString y ++ "px") )
                ]


defaultPadding : ( Maybe Float, Maybe Float, Maybe Float, Maybe Float ) -> ( Float, Float, Float, Float ) -> ( Float, Float, Float, Float )
defaultPadding ( mW, mX, mY, mZ ) ( w, x, y, z ) =
    ( Maybe.withDefault w mW
    , Maybe.withDefault x mX
    , Maybe.withDefault y mY
    , Maybe.withDefault z mZ
    )


renderElement : Maybe Parent -> Internal.StyleSheet elem variation -> Order -> Element elem variation msg -> Html msg
renderElement parent stylesheet order elm =
    case elm of
        Empty ->
            Html.text ""

        Raw html ->
            html

        Spacer x ->
            let
                ( spacingX, spacingY, _, _ ) =
                    case parent of
                        Just ctxt ->
                            ctxt.parentSpecifiedSpacing
                                |> Maybe.withDefault ( 0, 0, 0, 0 )

                        Nothing ->
                            ( 0, 0, 0, 0 )

                forSpacing posAttr =
                    case posAttr of
                        Spacing spaceX spaceY ->
                            Just ( spaceX, spaceY )

                        _ ->
                            Nothing

                inline =
                    [ ( "width", (toString (x * spacingX) ++ "px") )
                    , ( "height", (toString (x * spacingY) ++ "px") )
                    , ( "visibility", "hidden" )
                    ]
            in
                Html.div [ Html.Attributes.style inline ] []

        Text dec str ->
            case dec of
                NoDecoration ->
                    Html.text str

                Bold ->
                    Html.strong [] [ Html.text str ]

                Italic ->
                    Html.em [] [ Html.text str ]

                Underline ->
                    Html.u [] [ Html.text str ]

                Strike ->
                    Html.s [] [ Html.text str ]

                Super ->
                    Html.sup [] [ Html.text str ]

                Sub ->
                    Html.sub [] [ Html.text str ]

        Element { node, style, attrs, child, absolutelyPositioned } ->
            let
                childHtml =
                    case absolutelyPositioned of
                        Nothing ->
                            [ renderElement Nothing stylesheet FirstAndLast child ]

                        Just absol ->
                            List.map (renderElement Nothing stylesheet FirstAndLast) (child :: absol)

                parentTextLayout layout =
                    case layout of
                        Internal.TextLayout _ ->
                            True

                        _ ->
                            False

                attributes =
                    case parent of
                        Nothing ->
                            spacingToMargin attrs

                        Just ctxt ->
                            case ctxt.parentSpecifiedSpacing of
                                Nothing ->
                                    if parentTextLayout ctxt.layout || List.any ((==) Inline) attrs then
                                        spacingToMargin attrs
                                    else
                                        attrs

                                Just ( top, right, bottom, left ) ->
                                    if parentTextLayout ctxt.layout || List.any ((==) Inline) attrs then
                                        Margin ( top, right, bottom, left ) :: spacingToMargin attrs
                                    else
                                        Margin ( top, right, bottom, left ) :: attrs

                htmlAttrs =
                    renderAttributes Single order style parent stylesheet (gather attributes)
            in
                Html.node node htmlAttrs childHtml

        Layout { node, layout, style, attrs, children, absolutelyPositioned } ->
            let
                -- TODO RENDER ABSOLUTELY POSITIONED CHILDREN
                ( centeredProps, others ) =
                    List.partition (\attr -> attr == HAlign Center || attr == VAlign VerticalCenter) attrs

                attributes =
                    case parent of
                        Nothing ->
                            attrs

                        Just ctxt ->
                            case ctxt.parentSpecifiedSpacing of
                                Nothing ->
                                    attrs

                                Just spacing ->
                                    Margin spacing :: attrs

                clearfix attrs =
                    case layout of
                        Internal.TextLayout clearfix ->
                            if clearfix then
                                Html.Attributes.class "clearfix" :: attrs
                            else
                                attrs

                        _ ->
                            attrs

                forPadding posAttr =
                    case posAttr of
                        Padding t r b l ->
                            Just <| defaultPadding ( t, r, b, l ) ( 0, 0, 0, 0 )

                        PhantomPadding box ->
                            Just box

                        _ ->
                            Nothing

                padding =
                    case List.head (List.filterMap forPadding attributes) of
                        Nothing ->
                            ( 0, 0, 0, 0 )

                        Just pad ->
                            pad

                findSpacing posAttr =
                    case posAttr of
                        Spacing x y ->
                            Just ( y, x, y, x )

                        _ ->
                            Nothing

                forSpacing =
                    (\x -> x /= Nothing) << findSpacing

                ( spacing, _ ) =
                    List.partition forSpacing attrs

                inherit =
                    { parentSpecifiedSpacing =
                        List.filterMap findSpacing attrs
                            |> List.head
                    , layout = layout
                    , parentPadding = padding
                    }

                isFlexbox layout =
                    case layout of
                        Internal.FlexLayout _ _ ->
                            True

                        _ ->
                            False

                -- Insert intermediate div if there are two display:flex items touching.
                adjacentFlexboxCorrection htmlNode =
                    case parent of
                        Nothing ->
                            htmlNode

                        Just p ->
                            if isFlexbox p.layout && isFlexbox layout then
                                -- Html.div [] [ htmlNode ]
                                htmlNode
                            else
                                htmlNode

                htmlAttrs =
                    renderAttributes (LayoutElement layout) order style parent stylesheet (gather attributes)
                        |> clearfix
            in
                case children of
                    Normal childList ->
                        let
                            childHtml =
                                List.indexedMap
                                    (\i child ->
                                        renderElement
                                            (Just inherit)
                                            stylesheet
                                            (detectOrder childList i)
                                            child
                                    )
                                    childList

                            allChildren =
                                case absolutelyPositioned of
                                    Nothing ->
                                        childHtml

                                    Just absol ->
                                        childHtml ++ (List.map (renderElement Nothing stylesheet FirstAndLast) absol)
                        in
                            adjacentFlexboxCorrection <| Html.node node htmlAttrs allChildren

                    Keyed keyed ->
                        let
                            -- DOES NOT RENDER ABSOLUTE CHILDREN
                            childHtml =
                                List.indexedMap
                                    (\i ( key, child ) ->
                                        ( key
                                        , renderElement
                                            (Just inherit)
                                            stylesheet
                                            (detectOrder keyed i)
                                            child
                                        )
                                    )
                                    keyed
                        in
                            adjacentFlexboxCorrection <| Html.Keyed.node node htmlAttrs childHtml


type alias Positionable variation msg =
    { inline : Bool
    , horizontal : Maybe HorizontalAlignment
    , vertical : Maybe VerticalAlignment
    , frame : Maybe Frame
    , expand : Bool
    , hidden : Bool
    , width : Maybe Internal.Length
    , height : Maybe Internal.Length
    , positioned : ( Maybe Float, Maybe Float, Maybe Float )
    , margin : Maybe ( Float, Float, Float, Float )
    , padding : ( Maybe Float, Maybe Float, Maybe Float, Maybe Float )
    , variations : List ( variation, Bool )
    , opacity : Maybe Float
    , gridPosition : Maybe String
    , pointerevents : Maybe Bool
    , attrs : List (Html.Attribute msg)
    , shrink : Maybe Int
    , overflow : Maybe Axis
    }


emptyPositionable : Positionable variation msg
emptyPositionable =
    { inline = False
    , horizontal = Nothing
    , vertical = Nothing
    , frame = Nothing
    , expand = False
    , hidden = False
    , width = Nothing
    , height = Nothing
    , positioned = ( Nothing, Nothing, Nothing )
    , margin = Nothing
    , padding = ( Nothing, Nothing, Nothing, Nothing )
    , variations = []
    , opacity = Nothing
    , gridPosition = Nothing
    , pointerevents = Nothing
    , attrs = []
    , shrink = Nothing
    , overflow = Nothing
    }


gather : List (Attribute variation msg) -> Positionable variation msg
gather attrs =
    List.foldl makePositionable emptyPositionable attrs


makePositionable : Attribute variation msg -> Positionable variation msg -> Positionable variation msg
makePositionable attr pos =
    case attr of
        Overflow x ->
            { pos | overflow = Just x }

        Shrink i ->
            { pos | shrink = Just i }

        Inline ->
            { pos | inline = True }

        Expand ->
            { pos | expand = True }

        Vary vary on ->
            { pos
                | variations = ( vary, on ) :: pos.variations
            }

        Height len ->
            { pos | height = Just len }

        Width len ->
            { pos | width = Just len }

        Position x y z ->
            let
                ( currentX, currentY, currentZ ) =
                    pos.positioned

                newX =
                    case x of
                        Nothing ->
                            currentX

                        Just a ->
                            Just a

                newY =
                    case y of
                        Nothing ->
                            currentY

                        Just a ->
                            Just a

                newZ =
                    case z of
                        Nothing ->
                            currentZ

                        Just a ->
                            Just a
            in
                { pos | positioned = ( newX, newY, newZ ) }

        PositionFrame frame ->
            { pos | frame = Just frame }

        HAlign alignment ->
            { pos | horizontal = Just alignment }

        VAlign alignment ->
            { pos | vertical = Just alignment }

        Spacing spaceX spaceY ->
            -- Spacing is converted into Margin to be rendered
            pos

        Margin box ->
            { pos | margin = Just box }

        PhantomPadding _ ->
            pos

        Padding top right bottom left ->
            let
                ( currentTop, currentRight, currentBottom, currentLeft ) =
                    pos.padding

                newTop =
                    case top of
                        Nothing ->
                            currentTop

                        Just a ->
                            Just a

                newRight =
                    case right of
                        Nothing ->
                            currentRight

                        Just a ->
                            Just a

                newBottom =
                    case bottom of
                        Nothing ->
                            currentBottom

                        Just a ->
                            Just a

                newLeft =
                    case left of
                        Nothing ->
                            currentLeft

                        Just a ->
                            Just a
            in
                { pos | padding = ( newTop, newRight, newBottom, newLeft ) }

        Hidden ->
            { pos | hidden = True }

        Opacity t ->
            { pos | opacity = Just t }

        Event ev ->
            { pos | attrs = ev :: pos.attrs }

        InputEvent ev ->
            { pos | attrs = ev :: pos.attrs }

        Attr attr ->
            { pos | attrs = attr :: pos.attrs }

        PointerEvents on ->
            { pos | pointerevents = Just on }

        GridArea name ->
            { pos | gridPosition = Just name }

        GridCoords coords ->
            case Value.gridPosition coords of
                Nothing ->
                    -- Invalid grid position like width = 0, so element should be hidden
                    { pos | hidden = True }

                Just xy ->
                    { pos | gridPosition = Just <| xy }


type Order
    = First
    | Middle Int
    | Last
    | FirstAndLast


type ElementType
    = Single
    | LayoutElement Internal.LayoutModel


alignLayout : Maybe HorizontalAlignment -> Maybe VerticalAlignment -> Internal.LayoutModel -> Internal.LayoutModel
alignLayout maybeHorizontal maybeVertical layout =
    let
        alignFlexboxHorizontal align =
            case align of
                Left ->
                    Internal.Horz (Internal.Other Internal.Left)

                Right ->
                    Internal.Horz (Internal.Other Internal.Right)

                Center ->
                    Internal.Horz (Internal.Center)

                Justify ->
                    Internal.Horz (Internal.Justify)

        alignFlexboxVertical align =
            case align of
                Top ->
                    Internal.Vert (Internal.Other Internal.Top)

                Bottom ->
                    Internal.Vert (Internal.Other Internal.Bottom)

                VerticalCenter ->
                    Internal.Vert (Internal.Center)

        alignGridHorizontal align =
            case align of
                Left ->
                    Internal.GridH (Internal.Other Internal.Left)

                Right ->
                    Internal.GridH (Internal.Other Internal.Right)

                Center ->
                    Internal.GridH (Internal.Center)

                Justify ->
                    Internal.GridH (Internal.Justify)

        alignGridVertical align =
            case align of
                Top ->
                    Internal.GridV (Internal.Other Internal.Top)

                Bottom ->
                    Internal.GridV (Internal.Other Internal.Bottom)

                VerticalCenter ->
                    Internal.GridV (Internal.Center)
    in
        case layout of
            Internal.TextLayout clearfix ->
                Internal.TextLayout clearfix

            Internal.FlexLayout dir els ->
                case ( maybeHorizontal, maybeVertical ) of
                    ( Nothing, Nothing ) ->
                        Internal.FlexLayout dir els

                    ( Just h, Nothing ) ->
                        Internal.FlexLayout dir (alignFlexboxHorizontal h :: els)

                    ( Nothing, Just v ) ->
                        Internal.FlexLayout dir (alignFlexboxVertical v :: els)

                    ( Just h, Just v ) ->
                        Internal.FlexLayout dir (alignFlexboxHorizontal h :: alignFlexboxVertical v :: els)

            Internal.Grid template els ->
                case ( maybeHorizontal, maybeVertical ) of
                    ( Nothing, Nothing ) ->
                        Internal.Grid template els

                    ( Just h, Nothing ) ->
                        Internal.Grid template (alignGridHorizontal h :: els)

                    ( Nothing, Just v ) ->
                        Internal.Grid template (alignGridVertical v :: els)

                    ( Just h, Just v ) ->
                        Internal.Grid template (alignGridHorizontal h :: alignGridVertical v :: els)


flexboxHorizontalIndividualAlignment :
    Internal.Direction
    -> HorizontalAlignment
    -> Maybe ( String, String )
flexboxHorizontalIndividualAlignment direction alignment =
    case direction of
        Internal.GoRight ->
            case alignment of
                Left ->
                    Nothing

                Right ->
                    Nothing

                Center ->
                    Nothing

                Justify ->
                    Nothing

        Internal.GoLeft ->
            case alignment of
                Left ->
                    Nothing

                Right ->
                    Nothing

                Center ->
                    Nothing

                Justify ->
                    Nothing

        Internal.Down ->
            case alignment of
                Left ->
                    Just ( "align-self", "flex-start" )

                Right ->
                    Just ( "align-self", "flex-end" )

                Center ->
                    Just ( "align-self", "center" )

                Justify ->
                    Just ( "align-self", "stretch" )

        Internal.Up ->
            case alignment of
                Left ->
                    Just ( "align-self", "flex-start" )

                Right ->
                    Just ( "align-self", "flex-end" )

                Center ->
                    Just ( "align-self", "center" )

                Justify ->
                    Just ( "align-self", "stretch" )


flexboxVerticalIndividualAlignment :
    Internal.Direction
    -> VerticalAlignment
    -> Maybe ( String, String )
flexboxVerticalIndividualAlignment direction alignment =
    case direction of
        Internal.GoRight ->
            case alignment of
                Top ->
                    Just ( "align-self", "flex-start" )

                Bottom ->
                    Just ( "align-self", "flex-end" )

                VerticalCenter ->
                    Just ( "align-self", "center" )

        Internal.GoLeft ->
            case alignment of
                Top ->
                    Just ( "align-self", "flex-start" )

                Bottom ->
                    Just ( "align-self", "flex-end" )

                VerticalCenter ->
                    Just ( "align-self", "center" )

        Internal.Down ->
            case alignment of
                Top ->
                    Nothing

                Bottom ->
                    Nothing

                VerticalCenter ->
                    Nothing

        Internal.Up ->
            case alignment of
                Top ->
                    Nothing

                Bottom ->
                    Nothing

                VerticalCenter ->
                    Nothing


renderAttributes : ElementType -> Order -> Maybe elem -> Maybe Parent -> Internal.StyleSheet elem variation -> Positionable variation msg -> List (Html.Attribute msg)
renderAttributes elType order maybeElemID parent stylesheet elem =
    let
        layout attrs =
            case elType of
                Single ->
                    if elem.inline then
                        ( "display", "inline" ) :: attrs
                    else
                        ( "display", "block" ) :: attrs

                LayoutElement lay ->
                    Property.layout elem.inline (alignLayout elem.horizontal elem.vertical lay) ++ attrs

        position attrs =
            (calcPosition (Maybe.withDefault Relative elem.frame) elem.positioned) ++ attrs

        passthrough attrs =
            case elem.pointerevents of
                Nothing ->
                    attrs

                Just False ->
                    ( "pointer-events", "none" ) :: attrs

                Just True ->
                    ( "pointer-events", "auto" ) :: attrs

        vertical attrs =
            case elem.vertical of
                Nothing ->
                    attrs

                Just align ->
                    if elem.inline && elType == Single then
                        attrs
                    else if elem.inline then
                        attrs
                    else if elem.frame /= Nothing then
                        case align of
                            Top ->
                                ( "top", "0" ) :: attrs

                            Bottom ->
                                ( "bottom", "0" ) :: attrs

                            VerticalCenter ->
                                -- If an element is centered,
                                -- it would be transformed to a single element centered layout before hitting here
                                attrs
                    else
                        case parent of
                            Nothing ->
                                attrs

                            Just { layout } ->
                                case layout of
                                    Internal.FlexLayout dir _ ->
                                        case flexboxVerticalIndividualAlignment dir align of
                                            Nothing ->
                                                attrs

                                            Just a ->
                                                a :: attrs

                                    _ ->
                                        attrs

        horizontal attrs =
            case elem.horizontal of
                Nothing ->
                    attrs

                Just align ->
                    if elem.inline && elType == Single then
                        case align of
                            Left ->
                                ( "z-index", "1" ) :: ( "float", "left" ) :: attrs

                            Right ->
                                ( "z-index", "1" ) :: ( "float", "right" ) :: attrs

                            Center ->
                                attrs

                            Justify ->
                                attrs
                    else if elem.inline then
                        attrs
                    else if elem.frame /= Nothing then
                        case align of
                            Left ->
                                ( "left", "0" ) :: attrs

                            Right ->
                                ( "right", "0" ) :: attrs

                            Center ->
                                -- If an element is centered,
                                -- it would be transformed to a single element centered layout before hitting here
                                attrs

                            Justify ->
                                attrs
                    else
                        case parent of
                            Nothing ->
                                attrs

                            Just { layout } ->
                                case layout of
                                    Internal.TextLayout _ ->
                                        case align of
                                            Left ->
                                                ( "z-index", "1" ) :: ( "float", "left" ) :: attrs

                                            Right ->
                                                ( "z-index", "1" ) :: ( "float", "right" ) :: attrs

                                            Center ->
                                                attrs

                                            Justify ->
                                                attrs

                                    Internal.FlexLayout dir _ ->
                                        case flexboxHorizontalIndividualAlignment dir align of
                                            Nothing ->
                                                attrs

                                            Just a ->
                                                a :: attrs

                                    _ ->
                                        attrs

        overflow attrs =
            case elem.overflow of
                Nothing ->
                    attrs

                Just o ->
                    case o of
                        XAxis ->
                            ( "overflow-x", "auto" ) :: attrs

                        YAxis ->
                            ( "overflow-y", "auto" ) :: attrs

                        AllAxis ->
                            ( "overflow", "auto" ) :: attrs

        shrink attrs =
            case elem.shrink of
                Just i ->
                    ( "flex-shrink", (toString i) ) :: attrs

                Nothing ->
                    case parent of
                        Nothing ->
                            attrs

                        Just { layout } ->
                            let
                                isPercent x =
                                    case x of
                                        Just (Internal.Percent _) ->
                                            True

                                        _ ->
                                            False

                                isPx x =
                                    case x of
                                        Just (Internal.Px _) ->
                                            True

                                        _ ->
                                            False

                                isHorizontal dir =
                                    case dir of
                                        Internal.GoRight ->
                                            True

                                        Internal.GoLeft ->
                                            True

                                        _ ->
                                            False

                                isVertical dir =
                                    case dir of
                                        Internal.Up ->
                                            True

                                        Internal.Down ->
                                            True

                                        _ ->
                                            False

                                verticalOverflow =
                                    case elem.overflow of
                                        Just XAxis ->
                                            False

                                        Just YAxis ->
                                            True

                                        Just AllAxis ->
                                            True

                                        _ ->
                                            False

                                horizontalOverflow =
                                    case elem.overflow of
                                        Just XAxis ->
                                            True

                                        Just YAxis ->
                                            False

                                        Just AllAxis ->
                                            True

                                        _ ->
                                            False
                            in
                                case layout of
                                    Internal.FlexLayout dir _ ->
                                        if isHorizontal dir && isPx elem.width then
                                            ( "flex-shrink", "0" ) :: attrs
                                        else if isHorizontal dir && isPercent elem.width then
                                            ( "flex-shrink", "0" ) :: attrs
                                        else if isHorizontal dir && elem.width /= Nothing then
                                            ( "flex-shrink", "1" ) :: attrs
                                        else if isHorizontal dir && horizontalOverflow then
                                            ( "flex-shrink", "1" ) :: attrs
                                        else if isVertical dir && isPx elem.height then
                                            ( "flex-shrink", "0" ) :: attrs
                                        else if isVertical dir && isPercent elem.height then
                                            ( "flex-shrink", "0" ) :: attrs
                                        else if isVertical dir && elem.height /= Nothing then
                                            ( "flex-shrink", "1" ) :: attrs
                                        else if isVertical dir && verticalOverflow then
                                            ( "flex-shrink", "1" ) :: attrs
                                            -- If width is not set, then we want it to wrap,
                                            -- which apparently involves flex-shrink being 1
                                        else if isHorizontal dir && elem.width == Nothing then
                                            ( "flex-shrink", "1" ) :: attrs
                                        else if isVertical dir && elem.height == Nothing then
                                            case elType of
                                                Single ->
                                                    ( "flex-shrink", "1" ) :: attrs

                                                LayoutElement elLayout ->
                                                    ( "flex-shrink", "0" ) :: attrs
                                        else
                                            ( "flex-shrink", "0" ) :: attrs

                                    _ ->
                                        attrs

        width attrs =
            case elem.width of
                Nothing ->
                    attrs

                Just len ->
                    case parent of
                        Just { layout, parentPadding, parentSpecifiedSpacing } ->
                            let
                                ( _, rightPad, _, leftPad ) =
                                    Maybe.withDefault ( 0, 0, 0, 0 ) parentSpecifiedSpacing

                                paddingAdjustment =
                                    (rightPad + leftPad) / 2
                            in
                                case layout of
                                    Internal.FlexLayout Internal.GoRight _ ->
                                        Property.flexWidth len paddingAdjustment :: attrs

                                    Internal.FlexLayout Internal.GoLeft _ ->
                                        Property.flexWidth len paddingAdjustment :: attrs

                                    _ ->
                                        ( "width", Value.parentAdjustedLength len paddingAdjustment ) :: attrs

                        Nothing ->
                            ( "width", Value.length len ) :: attrs

        height attrs =
            case elem.height of
                Nothing ->
                    attrs

                Just len ->
                    case parent of
                        Just { layout, parentSpecifiedSpacing } ->
                            let
                                ( topPad, _, bottomPad, _ ) =
                                    Maybe.withDefault ( 0, 0, 0, 0 ) parentSpecifiedSpacing

                                paddingAdjustment =
                                    (topPad + bottomPad) / 2

                                hundredPercentOrFill x =
                                    case x of
                                        Internal.Percent p ->
                                            p == 100

                                        Internal.Fill _ ->
                                            True

                                        Internal.Calc perc _ ->
                                            perc == 100

                                        _ ->
                                            False
                            in
                                case layout of
                                    Internal.FlexLayout Internal.Down _ ->
                                        Property.flexHeight len :: attrs

                                    Internal.FlexLayout Internal.Up _ ->
                                        Property.flexHeight len :: attrs

                                    Internal.FlexLayout Internal.GoRight _ ->
                                        if hundredPercentOrFill len then
                                            ( "height", "auto" ) :: attrs
                                        else
                                            ( "height", Value.parentAdjustedLength len paddingAdjustment ) :: attrs

                                    Internal.FlexLayout Internal.GoLeft _ ->
                                        if hundredPercentOrFill len then
                                            ( "height", "auto" ) :: attrs
                                        else
                                            ( "height", Value.parentAdjustedLength len paddingAdjustment ) :: attrs

                                    _ ->
                                        ( "height", Value.parentAdjustedLength len paddingAdjustment ) :: attrs

                        Nothing ->
                            ( "height", Value.length len ) :: attrs

        opacity attrs =
            case elem.opacity of
                Nothing ->
                    attrs

                Just o ->
                    ( "opacity", toString o ) :: attrs

        padding attrs =
            let
                paddings =
                    renderPadding elem.padding
            in
                if List.length paddings > 0 then
                    paddings ++ attrs
                else
                    attrs

        gridPos attrs =
            case elem.gridPosition of
                Nothing ->
                    attrs

                Just area ->
                    ( "grid-area", area ) :: attrs

        spacing attrs =
            case elem.margin of
                Nothing ->
                    attrs

                Just space ->
                    ( "margin", Value.box <| adjustspacing space ) :: attrs

        -- When an element is floated, it's spacing is affected
        adjustspacing ( top, right, bottom, left ) =
            let
                halved =
                    ( top / 2
                    , right / 2
                    , bottom / 2
                    , left / 2
                    )

                onScreen =
                    case elem.frame of
                        Just Screen ->
                            True

                        _ ->
                            False
            in
                if onScreen then
                    ( 0, 0, 0, 0 )
                else
                    case parent of
                        Nothing ->
                            ( top, right, bottom, left )

                        Just { layout } ->
                            case layout of
                                Internal.TextLayout _ ->
                                    case elem.horizontal of
                                        Nothing ->
                                            if order == Last || order == FirstAndLast then
                                                ( 0, 0, 0, 0 )
                                            else if elem.inline then
                                                -- If an element is inline, spacing is horizontal, otherwise it's vertical.
                                                ( 0, right, 0, 0 )
                                            else
                                                ( 0, 0, bottom, 0 )

                                        Just align ->
                                            if not elem.inline && elem.frame == Nothing then
                                                case align of
                                                    Left ->
                                                        if order == First then
                                                            ( 0, right, bottom, 0 )
                                                        else if order == FirstAndLast then
                                                            ( 0, right, 0, 0 )
                                                        else if order == Last then
                                                            ( 0, right, 0, 0 )
                                                        else
                                                            ( 0, right, bottom, 0 )

                                                    Right ->
                                                        if order == First then
                                                            ( 0, 0, bottom, left )
                                                        else if order == FirstAndLast then
                                                            ( 0, 0, 0, left )
                                                        else if order == Last then
                                                            ( 0, 0, 0, left )
                                                        else
                                                            ( 0, 0, bottom, left )

                                                    _ ->
                                                        if order == Last || order == FirstAndLast then
                                                            ( 0, 0, 0, 0 )
                                                        else
                                                            ( 0, 0, bottom, 0 )
                                            else
                                                ( top
                                                , right
                                                , bottom
                                                , left
                                                )

                                _ ->
                                    halved

        defaults =
            [ ( "box-sizing", "border-box" )
            ]

        attributes =
            case maybeElemID of
                Nothing ->
                    elem.attrs

                Just elemID ->
                    if List.length elem.variations > 0 then
                        Html.Attributes.classList (stylesheet.variations elemID elem.variations) :: elem.attrs
                    else
                        Html.Attributes.class (stylesheet.style elemID) :: elem.attrs
    in
        if elem.hidden then
            Html.Attributes.style [ ( "display", "none" ) ] :: attributes
        else if elem.expand then
            let
                expandedProps =
                    case parent of
                        Nothing ->
                            [ ( "width", "100%" )
                            , ( "height", "100%" )
                            , ( "margin", "0" )
                            ]

                        Just { layout, parentPadding, parentSpecifiedSpacing } ->
                            case layout of
                                Internal.TextLayout _ ->
                                    let
                                        ( top, right, bottom, left ) =
                                            parentPadding

                                        borders =
                                            List.concat
                                                [ if order == Last then
                                                    [ ( "border-top-right-radius", "0" )
                                                    , ( "border-top-left-radius", "0" )
                                                    ]
                                                  else if order == First then
                                                    [ ( "border-bottom-right-radius", "0" )
                                                    , ( "border-bottom-left-radius", "0" )
                                                    ]
                                                  else if order == FirstAndLast then
                                                    [ ( "border-top-right-radius", "0" )
                                                    , ( "border-top-left-radius", "0" )
                                                    , ( "border-bottom-right-radius", "0" )
                                                    , ( "border-bottom-left-radius", "0" )
                                                    ]
                                                  else
                                                    []
                                                ]
                                    in
                                        [ ( "width", ("calc(100% + " ++ toString (right + left) ++ "px") )
                                        , ( "margin", "0" )
                                        , ( "margin-left", (toString (-1 * left) ++ "px") )
                                        , if order == First || order == FirstAndLast then
                                            ( "margin-top", (toString (-1 * top) ++ "px") )
                                          else
                                            ( "margin-top", "0" )
                                        , if order == Last || order == FirstAndLast then
                                            ( "margin-bottom", (toString (-1 * bottom) ++ "px") )
                                          else
                                            ( "margin-bottom", "0" )
                                        , ( "padding", (Value.box <| defaultPadding elem.padding parentPadding) )
                                        ]
                                            ++ borders

                                Internal.FlexLayout dir flex ->
                                    let
                                        ( top, right, bottom, left ) =
                                            parentPadding

                                        ( parentSpaceTop, parentSpaceRight, parentSpaceBottom, parentSpaceLeft ) =
                                            case parentSpecifiedSpacing of
                                                Nothing ->
                                                    ( 0, 0, 0, 0 )

                                                Just p ->
                                                    p
                                    in
                                        case dir of
                                            Internal.GoRight ->
                                                width
                                                    [ ( "height", ("calc(100% + " ++ toString (top + bottom - ((parentSpaceTop + parentSpaceBottom) / 2)) ++ "px") )
                                                    , ( "margin", "0" )
                                                    , ( "margin-top", (toString ((-1 * top) + (parentSpaceTop / 2)) ++ "px") )
                                                    , if order == First || order == FirstAndLast then
                                                        ( "margin-left", (toString (-1 * left) ++ "px") )
                                                      else
                                                        ( "margin-left", (toString (parentSpaceLeft / 2) ++ "px") )
                                                    , if order == Last || order == FirstAndLast then
                                                        ( "margin-right", (toString (-1 * right) ++ "px") )
                                                      else
                                                        ( "margin-right", (toString (parentSpaceRight / 2) ++ "px") )
                                                    ]

                                            Internal.GoLeft ->
                                                width
                                                    [ ( "height", ("calc(100% + " ++ toString (top + bottom - ((parentSpaceTop + parentSpaceBottom) / 2)) ++ "px") )
                                                    , ( "margin", "0" )
                                                    , ( "margin-top", (toString ((-1 * top) + (parentSpaceTop / 2)) ++ "px") )
                                                    , if order == First || order == FirstAndLast then
                                                        ( "margin-right", (toString (-1 * right) ++ "px") )
                                                      else
                                                        ( "margin-right", (toString (parentSpaceRight / 2) ++ "px") )
                                                    , if order == Last || order == FirstAndLast then
                                                        ( "margin-left", (toString (-1 * left) ++ "px") )
                                                      else
                                                        ( "margin-left", (toString (parentSpaceLeft / 2) ++ "px") )
                                                    ]

                                            Internal.Up ->
                                                height
                                                    [ ( "width", ("calc(100% + " ++ toString (left + right - ((parentSpaceLeft + parentSpaceRight) / 2)) ++ "px") )
                                                    , ( "margin", "0" )
                                                    , ( "margin-left", (toString ((-1 * left) + (parentSpaceLeft / 2)) ++ "px") )
                                                    , if order == First || order == FirstAndLast then
                                                        ( "margin-bottom", (toString (-1 * top) ++ "px") )
                                                      else
                                                        ( "margin-bottom", (toString (parentSpaceBottom / 2) ++ "px") )
                                                    , if order == Last || order == FirstAndLast then
                                                        ( "margin-top", (toString (-1 * bottom) ++ "px") )
                                                      else
                                                        ( "margin-top", (toString (parentSpaceTop / 2) ++ "px") )
                                                    ]

                                            Internal.Down ->
                                                height
                                                    [ ( "width", ("calc(100% + " ++ toString (left + right - ((parentSpaceLeft + parentSpaceRight) / 2)) ++ "px") )
                                                    , ( "margin", "0" )
                                                    , ( "margin-left", (toString ((-1 * left) + (parentSpaceLeft / 2)) ++ "px") )
                                                    , if order == First || order == FirstAndLast then
                                                        ( "margin-top", (toString (-1 * top) ++ "px") )
                                                      else
                                                        ( "margin-top", (toString (parentSpaceTop / 2) ++ "px") )
                                                    , if order == Last || order == FirstAndLast then
                                                        ( "margin-bottom", (toString (-1 * bottom) ++ "px") )
                                                      else
                                                        ( "margin-bottom", (toString (parentSpaceBottom / 2) ++ "px") )
                                                    ]

                                _ ->
                                    []
            in
                (Html.Attributes.style
                    (( "box-sizing", "border-box" ) :: ((passthrough << gridPos << layout << spacing << opacity << shrink << padding << position << overflow) <| expandedProps))
                )
                    :: attributes
        else
            (Html.Attributes.style
                ((passthrough << gridPos << layout << spacing << opacity << shrink << width << height << padding << horizontal << vertical << position << overflow) <| defaults)
            )
                :: attributes


renderPadding ( top, right, bottom, left ) =
    let
        format name x =
            ( name, toString x ++ "px" )
    in
        List.filterMap identity
            [ Maybe.map (format "padding-top") top
            , Maybe.map (format "padding-bottom") bottom
            , Maybe.map (format "padding-left") left
            , Maybe.map (format "padding-right") right
            ]
