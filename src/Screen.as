package {
import flash.utils.Dictionary;

import starling.display.Sprite;

public class Screen extends Sprite {

    private var _elements:Dictionary;
    private var _interactions:Array;

    public function Screen() {

        _interactions = new Array();
        _elements = new Dictionary();

    }

    public function addElement(element:Element):void {

        _elements[element.name] = element;
        addChild(element);

    }

    public function addInteraction(interaction:Interaction):void {

        interaction.setElements(_elements);
        _interactions[interaction.name] = interaction;


    }

























}
}
