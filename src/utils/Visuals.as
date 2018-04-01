package utils {
import flash.geom.Point;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Quad;
import starling.utils.Color;

public class Visuals {

    public static function center(dO:DisplayObject):void {

        dO.pivotX = dO.width / 2;
        dO.pivotY = dO.height / 2;

    }

    public static function showPivot(dO:DisplayObjectContainer):void {

        var point:Point = new Point(dO.pivotX, dO.pivotY);
        var quad:Quad = new Quad(3, 3, Color.AQUA);
        quad.x = point.x;
        quad.y = point.y;
        dO.addChild(quad);

    }



}
}
