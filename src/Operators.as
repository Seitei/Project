package {
import flash.utils.Dictionary;

public class Operators {

    private static var _instance:Operators;

    private var _screenElements:Dictionary;

    private var _operators:Dictionary = new Dictionary();


    public function Operators():void {
        init();
    }


    public function init():void {

        _screenElements = new Dictionary();

        _operators["=="] = equalEqual;
        _operators["<"] = lesserThan;
        _operators[">"] = greaterThan;


        _operators["+="] = plusEqual;
        _operators["-="] = minusEqual;
        _operators["+"]  = plus;
        _operators["++"]  = plusPlus;

    }



    public function addScreen(screen:Screen):void {

        _screenElements[screen.name] = screen.getElements();

    }



    public function runOperator(screen:String, left:Array, operator:String, right:Array):Object {

        var newLeftValue:Object = left[0];
        var newRightValue:Object = right[0];

        while(left.length > 1){

            newLeftValue = (_operators[left[1]](screen, left[0], left[2]));
            left.splice(0, 3);
            left.insertAt(0, newLeftValue);

        }

        while(right.length > 1){

            newRightValue = (_operators[right[1]](screen, right[0], right[2]));
            right.splice(0, 3);
            right.insertAt(0, newRightValue);

        }

        return _operators[operator](screen, newLeftValue, newRightValue);

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

        return Number(nValue1) == Number(nValue2);

    }

    public function lesserThan(screen:String, value1:Object, value2:Object):Boolean {

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

        return Number(nValue1) < Number(nValue2);

    }

    public function greaterThan(screen:String, value1:Object, value2:Object):Boolean {

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

        return Number(nValue1) > Number(nValue2);

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















    public function plusEqual(screen:String, value1:Object, value2:Object):void {

        var nValue2:Object;

        if(value2["element"]){
            nValue2 = _screenElements[screen][value2.element][value2.property];
        }
        else {
            nValue2 = value2["value"];
        }

        _screenElements[screen][value1.element][value1.property] += Number(nValue2);

    }

    public function minusEqual(screen:String, value1:Object, value2:Object):void {

        var nValue2:Object;

        if(value2["element"]){
            nValue2 = _screenElements[screen][value2.element][value2.property];
        }
        else {
            nValue2 = value2["value"];
        }

        _screenElements[screen][value1.element][value1.property] -= Number(nValue2);

    }










    public function plusPlus(screen:String, value1:Object, value2:Object):void {

        _screenElements[screen][value1.element][value1.property] ++;

    }
















    public static function getInstance():Operators {

        if(!_instance){
            _instance = new Operators();
        }

        return _instance;
    }




























}
}
