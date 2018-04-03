package {
import flash.utils.Dictionary;

public class IBlock {

    private static var conditionSymbols:Array =      ["==", "!=", "||", "&&", "<", ">", "<=", ">="];
    private static var propertyUpdateSymbols:Array = ["=", "+=", "-=", "++", "--"];
    private static var operationsUpdateSymbols:Array = ["+", "-", "/", "*"];

    private static var branchSymbols:Array = ["branchExclusive", "branchMultiple"];

    private var _id:int;
    private var _branches:Array;
    private var _next:int;
    private var _elements:Array;
    private var _code:String;
    private var _executionArray:Dictionary;
    private var _type:String;
    private var _screen:String;

    public function IBlock(screen:String, properties:Object) {

        _id = properties.id;
        _next = properties.next;
        _branches = properties.branches;
        _code = properties.code;
        _type = properties.type;

        _type = "condition";
        _code = "5 + 7 == 10"

        _screen = screen;

        processCode();

    }

    public function getBranches():Array {
        return _branches;
    }

    public function getNext():int {
        return _next;
    }

    private function processCode():void {

        _elements = new Array();
        _executionArray = new Dictionary();

        var arrayCheck:Array = _type == "condition" ? conditionSymbols : propertyUpdateSymbols;

        var segments:Array = _code.split(" ");

        var leftArray:Array = new Array();
        var rightArray:Array = new Array();

        for (var i:int = 0; i < segments.length; i++) {

            if(arrayCheck.indexOf(segments[i]) != -1){

                _executionArray["operator"] = segments[i];
                rightArray = segments.slice(i + 1);
                break;

            }

            leftArray.push(segments[i]);

        }

        _executionArray["left"] = processArray(leftArray);
        _executionArray["right"] = processArray(rightArray);


    }

    private function processArray(array:Array):Array {

        var resultArray:Array = new Array();

        for (var i:int = 0; i < array.length; i++) {

            var object:Object = new Object();

            if(array[i].indexOf(".") != -1){

                var string:String = array[i];
                var elementName:String = string.substr(0, string.indexOf("."));

                var property:String = string.substr(string.indexOf(".") + 1, 1);
                object = {element: elementName, property: property};

            }
            else if(operationsUpdateSymbols.indexOf(array[i]) != -1) {

                object = array[i];

            }
            else {

                object = {value: array[i]};

            }

            resultArray.push(object);

        }

        return resultArray;

    }

    public function execute():void {

        /*

        var left:Array  = [{element: "element0", property: "x"}];
        var right:Array = [{value: 5}];

        var left:Array  = [{value: 3}];
        var left:Array  = [{value: 3}, "+", {value: 5}];
        var right:Array = [{value: 3}];


        var left:Array  = [{element: "element0", property: "x"}, "+", {value: 5}];
        var operator:String = "==";
        var right:Array = [{value: 5}];

        */

        var result:Object = Operators.getInstance().runOperator(_screen, _executionArray["left"], _executionArray["operator"], _executionArray["right"]);

        trace(result);

    }























}
}
