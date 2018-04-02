package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.filesystem.File;
import flash.system.Capabilities;

import starling.core.Starling;
import starling.events.Event;
import starling.utils.AssetManager;

import utils.Resources;

[SWF(backgroundColor="#1d1d1d", frameRate="60", width="640", height="960")]
public class Main extends Sprite
{

    private var _starling:Starling;

    public function Main()
    {

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        _starling = new Starling(Root, stage);
        _starling.antiAliasing = 8;

        _starling.enableErrorChecking = Capabilities.isDebugger;

        _starling.addEventListener(Event.ROOT_CREATED, function(e:Event):void
        {
            loadAssets(startGame);
        });

        _starling.start();


    }

    private function loadAssets(onComplete:Function):void
    {

        var appDir:File = File.applicationDirectory;
        var assets:AssetManager = new AssetManager();

        assets.verbose = Capabilities.isDebugger;
        assets.enqueue(
                appDir.resolvePath("assets/")
        );

        assets.loadQueue(function(ratio:Number):void
        {
            if (ratio == 1) {

                onComplete(assets);
            }
        });
    }

    private function startGame(assets:AssetManager):void {

        Resources.assets = assets;
        Resources.stageWidth = stage.stageWidth;
        Resources.stageHeight = stage.stageHeight;

        Root.getInstance().start();

    }








































}
}