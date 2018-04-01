package utils {
import feathers.controls.TextInput;
import feathers.controls.text.TextFieldTextEditor;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;


import flash.utils.Dictionary;

import starling.text.TextFormat;

import starling.utils.Align;

public class Text {

    private static var _instance:Text;
    private var _defaultTextFormatStarling:starling.text.TextFormat = new starling.text.TextFormat("Consolas", 12, Constants.TEXT_COLOR, Align.LEFT, Align.TOP);
    private var _defaultTextFormatFlash:flash.text.TextFormat = new flash.text.TextFormat("Consolas", 12, Constants.TEXT_COLOR, Align.LEFT, Align.TOP);
    private var _defaultTextFormatPromptFlash:flash.text.TextFormat = new flash.text.TextFormat("Consolas", 12, Constants.PROMPT_TEXT_COLOR, Align.LEFT, Align.TOP);
    private var _storedTextFormats:Dictionary = new Dictionary();

    public function createTextInput():TextInput {

        var textInput:TextInput = new TextInput();
        textInput.textEditorFactory = textFactory;
        textInput.promptFactory = promptFactory;
        return textInput;

    }

    private function textFactory():ITextEditor {

        var textfield:TextFieldTextEditor = new TextFieldTextEditor();
        var tf:flash.text.TextFormat = _defaultTextFormatFlash;
        textfield.textFormat = tf;
        return textfield;

    }

    private function promptFactory():ITextRenderer {

        var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        var tf:flash.text.TextFormat = _defaultTextFormatPromptFlash;
        renderer.textFormat = tf;
        return renderer;

    }

    public function getTextFormat(replace:Object = null, store:String = null):starling.text.TextFormat {

        if(store){
            if(_storedTextFormats[store]){
                return _storedTextFormats[store];
            }
        }

        if(!replace){
            return _defaultTextFormatStarling;
        }

        var textFormat:starling.text.TextFormat = _defaultTextFormatStarling.clone();

        for(var value:String in replace){
            textFormat[value] = replace[value];
        }

        if(store){
            _storedTextFormats[store] = textFormat;
        }

        return textFormat;
    }

    public static function getInstance():Text {
        if(!_instance){
            _instance = new Text();
        }
        return _instance;
    }



}










}