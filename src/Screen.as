package {
import flash.utils.Dictionary;

import starling.display.Sprite;

public class Screen extends Sprite {

    private var _elements:Dictionary;
    private var _interactions:Dictionary;

    public function Screen() {

        _interactions = new Dictionary();
        _elements = new Dictionary();

    }

    public function addElement(element:Element):void {

        _elements[element.name] = element;
        addChild(element);

    }

    public function addInteraction(interaction:Interaction):void {

        _interactions[interaction.name] = interaction;

    }
}
}
