package utils {

import flash.utils.Dictionary;

public class DictionaryExtended {

    private var _dictionary:Dictionary;
    private var _array:Array;
    private var _count:Number = 0;
    private var _object:Object;

    public function DictionaryExtended(weakKeys:Boolean = false):void {

        _dictionary =  new Dictionary(weakKeys);
        _array = new Array();
        _object = new Object();

    }

    public function getValue(key:Object):Object {
        return _dictionary[key];
    }

    public function getElementsAfterThis(key:Object):Array {
        return _array.slice(getElementPosition(key) + 1);
    }

    public function getElementPosition(key:Object):Number {
        return _array.indexOf((_dictionary[key]));
    }

    public function getDic():Dictionary {
        return _dictionary;
    }

    public function getArray():Array {
        return _array;
    }

    public function updateValue(key:Object, value:Object):void {
        deleteValue(key);
        addValue(key, value);
    }

    public function addValue(key:Object, value:Object, doNotAddIfNull:Boolean = false):void {

        if(doNotAddIfNull && !value){
            return;
        }

        if(!_dictionary[key]){
            _array.push(value);
            _count ++;
        }
        else {
            _array[_array.indexOf(_dictionary[key])] = value;
        }
        _dictionary[key] = value;
        _object[key] = value;
    }

    public function addValues(key:Object, values:Array):void {

        for (var i:int = 0; i < values.length; i++) {
            addValue(values[i][key], values[i]);
        }
    }

    public function addValueAt(key:Object, value:Object, index:int):void {

        _array.insertAt(index, value);
        _count ++;
        _dictionary[key] = value;
        _object[key] = value;
    }

    public function deleteAllValues(removeFromStage:Boolean = false):void {

        for(var key:String in _dictionary) {
            deleteValue(key, removeFromStage);
        }
    }

    public function deleteValue(key:Object, removeFromStage:Boolean = false):void {

        if(removeFromStage){
            _dictionary[key].parent.removeChild(_dictionary[key]);
        }
        _array.removeAt(_array.indexOf(_dictionary[key]));
        delete _dictionary[key];
        delete _object[key];
        _count --;

    }

    public function getLength():Number {
        return _count;
    }

    public function getFirstElement():Object {
        return _array[0];
    }

    public function getLastElement():Object {
        return _array[_array.length - 1];
    }

    public function getElements(ids:Array):Array {

        var subArray:Array = new Array();

        for (var i:int = 0; i < ids.length; i++) {
            subArray.push(_dictionary[ids[i]])
        }

        return subArray;

    }

    public function getObject():Object {
        return _object;
    }

}










}