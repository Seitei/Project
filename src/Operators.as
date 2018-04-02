package {
import flash.utils.Dictionary;

public class Operators {

    private static var conditionSymbols:Array =      ["==", "!=", "||", "&&", "<", ">", "<=", ">="];
    private static var propertyUpdateSymbols:Array = ["=", "+=", "-=", "++", "--"];

    private static var _operators:Dictionary = new Dictionary();
    _operators["+="] = plusEqual;

    public static function runOperator(operator:String, target:String, params:Array):void {

        _operators[operator](target, params);

    }

    public static function plusEqual(target1:Element, accessor1:String, value:Array):void {

        if(value.length == 1){
            target1[accessor1] += value[0];
        }
        else {
            target1[accessor1] += value[0][value[1]];
        }

    }

    public static function EqualEqual(target1:Element, target2:Element, accessor:String ):Boolean {

        return target1[accessor] == target2[accessor];

    }


    public static function begin(target:Element, params:Array = null):void {

    //    target.addEventListener(TouchEvent.TOUCH, );

    }































}
}
