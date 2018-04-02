package {
import flash.utils.Dictionary;

public class Interaction {

    private var _name:String;
    private var _properties:Object;

    private var _elements:Array;
    private var _iBlocks:Dictionary;

    public function Interaction(properties:Object) {

        _properties = properties;
        _elements = _properties["elements"];
        _iBlocks = new Dictionary();

        _name = _properties["name"];

        build(0);

    }

    public function setElements():void {

    }

    public function get name():String {
        return _name;
    }

    public function build(id:int):void {

        var iBlock:IBlock = createNewIBlock(_properties["iBlocks"][id]);

        var branches:Array = iBlock.getBranches();

        for (var i:int = 0; i < branches.length; i++) {
            build(branches[i]);
        }

        var nextId:int = iBlock.getNext();

        if(nextId != -1){
            build(nextId);
        }

    }

    private function createNewIBlock(data:Object):IBlock {

        var iBlock:IBlock = new IBlock(data);

        _iBlocks[data.id] = iBlock;

        return iBlock;

    }








    public function execute(id:int = 0):void {

        var iBlock:IBlock = _iBlocks[id];

        var branches:Array = iBlock.getBranches();

        for (var i:int = 0; i < branches.length; i++) {
            execute(branches[i]);
        }

        var nextId:int = iBlock.getNext();

        if(nextId != -1){
            execute(nextId);
        }

    }





















}
}
