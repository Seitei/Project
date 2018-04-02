package {
import starling.utils.execute;

public class IBlock {

    private var _id:int;
    private var _branches:Array;
    private var _next:int;
    private var _targets:Array;
    private var _code:String;
    private var _executionArray:Array;

    public function IBlock(properties:Object) {

        _id = properties.id;
        _next = properties.next;
        _branches = properties.branches;
        _code = properties.code;

        processCode();

    }

    public function setTargets():void {
        _targets
    }

    public function getBranches():Array {
        return _branches;
    }

    public function getNext():int {
        return _next;
    }

    private function processCode():void {

        _targets = new Array();
        _executionArray = new Array();

        var segments:Array = _code.split(" ");

        //element0.trigger = BEGIN

        //element0.x += 5

        //element0.x += element1.y

        //element0.x == 5

        var segment:String = segments[0];

        var target:Element = segment.substr(0, segment.indexOf("."));
        _targets.push(target);
        _executionArray.push(target);

        var accessor:String = segment.substr(segment.indexOf(".") + 1);
        _executionArray.push(accessor);

        var operator:String = segments[1];
        _executionArray.push(operator);

        var value:String = segments[2];

        var valueSegments:Array = value.split(".");

        for (var i:int = 0; i < valueSegments.length; i++) {

            _executionArray.push(valueSegments[i]);

        }

        execute();
    }

    public function execute():void {

        var target:String = _executionArray[0];
        var operator:String = _executionArray[2];
        var params:Array = _executionArray.slice(3);

        Operators.runOperator(operator, target, params);

    }























}
}
