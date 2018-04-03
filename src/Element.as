package {
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.utils.Color;

import utils.Resources;

public class Element extends Sprite {

    private var _defaultBackgroundColor:uint = Color.GRAY;

    private var _properties:Object;
    private var _background:Quad;
    private var _color:uint;

    public function Element(properties:Object) {

        _properties = properties;

        init();

        processElementProperties();

    }

    private function init():void {

        _background = new Quad(_properties["width"], _properties["height"], _defaultBackgroundColor);
        addChild(_background);

    }


    protected function processElementProperties():void {

        for(var property:String in _properties){
            this[property] = _properties[property];
        }
    }

    /////////////////////////////////////////////////////////////////////////

    public function set color(value:String):void {
        _color = uint("0x" + value);
        _background.color = _color;
    }


    /////////////////////////////////////////////////////////////////////////

    public function set image(path:String):void {

        var texture:Texture = Resources.assets.getTexture(path);
        var image:Image = new Image(texture);

        addChild(image);

    }

    /////////////////////////////////////////////////////////////////////////






















}
}
