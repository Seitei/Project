package {
import flash.utils.Dictionary;

public class Operators {

    private static var _conditionSymbols:Array =      ["==", "!=", "||", "&&", "<", ">", "<=", ">="];
    private static var _propertyUpdateSymbols:Array = ["=", "+=", "-=", "++", "--"];
    private static var _operationsUpdateSymbols:Array = ["+", "-", "/", "*"];

    private static var _instance:Operators;

    private var _screenElements:Dictionary;

    private var _operators:Dictionary = new Dictionary();


    public function Operators():void {
        init();
    }


    public function init():void {

        _screenElements = new Dictionary();

        _operators["+="] = plusEqual;
        _operators["=="] = equalEqual;
        _operators["+"]  = plus;

    }



    public function addScreen(screen:Screen):void {

        _screenElements[screen.name] = screen.getElements();

    }



    public function runOperator(screen:String, left:Array, operator:String, right:Array):Object {

        var newLeft:Object = left;
        var newRight:Object = right;

        if(newLeft.length > 1){
            newLeft = _operators[newLeft[1]](screen, newLeft[0], newLeft[2]);
        }
        else {
            newLeft = left[0];
        }

        if(newRight.length > 1){
            newRight = _operators[newRight[1]](screen, newRight[0], newRight[2]);
        }
        else {
            newRight = right[0];
        }

        return _operators[operator](screen, newLeft, newRight);

    }


    public function equalEqual(screen:String, value1:Object, value2:Object):Boolean {

        var nValue1:Object;
        var nValue2:Object;

        if(value1["element"]){
            nValue1 = _screenElements[screen][value1.element][value1.property];
        }
        else {
            nValue1 = value1["value"];
        }

        if(value2["element"]){
            nValue2 = _screenElements[screen][value2.element][value2.property];
        }
        else {
            nValue2 = value2["value"];
        }

        return nValue1 == nValue2;

    }


    public function plus(screen:String, value1:Object, value2:Object):Object {

        var nValue1:Object;
        var nValue2:Object;

        if(value1["element"]){
            nValue1 = _screenElements[screen][value1.element][value1.property];
        }
        else {
            nValue1 = value1["value"];
        }

        if(value2["element"]){
            nValue2 = _screenElements[screen][value2.element][value2.property];
        }
        else {
            nValue2 = value2["value"];
        }

        return {value: Number(nValue1) + Number(nValue2)};

    }

    public function plusEqual(screen:String, value1:Object, value2:Object):Object {

        var nValue2:Object;

        if(value2["element"]){
            nValue2 = _screenElements[screen][value2.element][value2.property];
        }
        else {
            nValue2 = value2["value"];
        }

        _screenElements[screen][value1.element][value1.property] += Number(nValue2);

        return _screenElements[screen][value1.element][value1.property];

    }












    public function plusPlus(screen:String, element:String):void {

        _screenElements[screen][element] ++;

    }






    public static function getInstance():Operators {

        if(!_instance){
            _instance = new Operators();
        }

        return _instance;
    }




























}
}
