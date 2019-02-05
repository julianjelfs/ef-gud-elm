module Components.Generic exposing (ComponentProp, extractAttribute, someProperty, someProperty2)

import Html exposing (..)
import Html.Attributes exposing (..)


type ComponentProp a msg
    = ComponentProp (Attribute msg)


extractAttribute : ComponentProp a msg -> Attribute msg
extractAttribute (ComponentProp a) =
    a


someProperty : ComponentProp a msg
someProperty =
    ComponentProp <| class "-some-class"


someProperty2 : Attribute msg
someProperty2 =
    class "-some-class"
