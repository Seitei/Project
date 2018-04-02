package {
import flash.utils.ByteArray;

public class Deserealizer {


    public static function createScreen(screenByteArray:ByteArray):Screen {

        var screen:Screen = new Screen();

        var object:Object;
        screenByteArray.position = 0;
        object = screenByteArray.readObject();

        var elements:Array = object.elements;
        var interactions:Array = object.interactions;

        for (var i:int = 0; i < elements.length; i++) {

            var element:Element = new Element(elements[i].properties);
            screen.addElement(element);

        }

        for (var j:int = 0; j < interactions.length; j++) {

            var interaction:Interaction = new Interaction(interactions[j].properties);
            screen.addInteraction(interaction);

        }

        return screen;

    }

































}
}