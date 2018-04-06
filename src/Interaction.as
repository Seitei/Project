package {
import flash.utils.Dictionary;

public class Interaction {

    private var _name:String;
    private var _properties:Object;

    private var _elements:Array;
    private var _iBlocks:Dictionary;
    private var _screen:String;
    private var _trigger:Object;

    public function Interaction(screen:String, properties:Object) {

        _properties = properties;
        _elements = _properties["elements"];
        _iBlocks = new Dictionary();
        _trigger = _properties["trigger"];
        _screen = screen;
        _name = _properties["name"];

        _properties["iBlocks"]["trigger"]["trigger"] = _trigger;

        build("trigger");

    }

    public function get name():String {
        return _name;
    }

    public function getTrigger():Object {
        return _trigger;
    }

    public function getScreen():String {
        return _screen;
    }

    public function build(id:String):void {

        var iBlock:IBlock = createNewIBlock(_properties["iBlocks"][id]);

        var branches:Array = iBlock.getBranches();

        for (var i:int = 0; i < branches.length; i++) {
            build(branches[i]);
        }

        var nextId:String = iBlock.getNext();

        if(nextId != "-1"){
            build(nextId);
        }

    }

    private function createNewIBlock(data:Object):IBlock {

        var iBlock:IBlock = new IBlock(_screen, data);

        _iBlocks[data.id] = iBlock;

        return iBlock;

    }




    public function execute(id:String = "trigger"):void {

        var iBlock:IBlock = _iBlocks[id];
        iBlock.execute();

        var branches:Array = iBlock.getBranches();

        for (var i:int = 0; i < branches.length; i++) {
            execute(branches[i]);
        }

        var nextId:String = iBlock.getNext();

        if(nextId != "-1"){
            execute(nextId);
        }

    }





















}
}
