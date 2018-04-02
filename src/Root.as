package {

import flash.utils.ByteArray;

import starling.display.Quad;

import starling.display.Sprite;

import utils.Files;

public class Root extends Sprite {

    private static var _instance:Root;

    public function Root() {

        _instance = this;

    }

    public function start():void {

        Files.getInstance().loadBinary("Interact/projects/project/screen1/screen1.bin", onLoaded);

    }

    private function onLoaded(byteArray:ByteArray):void {

        var screen:Screen;
        screen = Deserealizer.createScreen(byteArray);
        addChild(screen);

    }

    public static function getInstance():Root {
        return _instance;
    }


}
}












































