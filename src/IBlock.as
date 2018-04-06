package {
import feathers.utils.display.stageToStarling;

import flash.utils.Dictionary;

import starling.core.Starling;
import starling.events.KeyboardEvent;

import utils.Constants;

public class IBlock {

    private static var conditionSymbols:Array =      ["==", "!=", "||", "&&", "<", ">", "<=", ">="];
    private static var propertyUpdateSymbols:Array = ["=", "+=", "-=", "++", "--"];
    private static var operationsUpdateSymbols:Array = ["+", "-", "/", "*"];

    private static var branchSymbols:Array = ["branchExclusive", "branchMultiple"];

    private var _id:String;
    private var _branches:Array;
    private var _next:String;
    private var _elements:Array;
    private var _code:String;
    private var _executionArray:Dictionary;
    private var _type:String;
    private var _subType:String;
    private var _screen:String;
    private var _interaction:Interaction;
    private var _trigger:Object;
    private var _originalBranches:Array;
    private var _originalNext:String;

    public function IBlock(screen:String, interaction:Interaction, properties:Object) {

        _id = properties.id;
        _next = properties.next;
        _originalNext = properties.next;
        _branches = properties.branches;
        _originalBranches = properties.branches;
        _code = properties.code;
        _type = properties.type;
        _subType = properties.subType;
        _screen = screen;
        _interaction = interaction;
        _trigger = properties.trigger;

        _elements = new Array();
        _executionArray = new Dictionary();

        if(_type != Constants.TRIGGER){
            processCode(_code);
        }
    }

    public function getBranches():Array {
        return _branches;
    }

    public function getNext():String {
        return _next;
    }

    public function setBranches(branches:Array):void {
        _branches = branches;
    }

    public function setNext(next:String):void {
        _next = next;
    }

    private function processCode(code:String):void {

        var arrayCheck:Array = _type == "condition" ? conditionSymbols : propertyUpdateSymbols;

        var segments:Array = code.split(" ");

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

    public function execute():Object {

        var result:Object;

        //leaving this here in case trigger iBlocks do something when executed in the future
        if(_type == Constants.TRIGGER){
            return null;
        }

        if(_subType == Constants.BRANCH_EXCLUSIVE){

            _branches = _originalBranches;

            for (var i:int = 0; i < _branches.length; i++) {

                var iBlockID:String = _branches[i];
                result = _interaction.getIBlock(_branches[i]).execute();

                if(result == true){
                    _branches = [iBlockID];
                    break;
                }
            }

            return null;

        }

        result = Operators.getInstance().runOperator(_screen, _executionArray["left"], _executionArray["operator"], _executionArray["right"]);

        if(_type == Constants.CONDITION){
            if(result == false){
                _next = "-1";
            }
            else {
                _next = _originalNext;
            }
        }

        return result;

    }























}
}
