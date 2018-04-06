package {
import flash.utils.ByteArray;

public class Deserealizer {


    public static function createScreen(screenByteArray:ByteArray):Screen {

        var object:Object;
        screenByteArray.position = 0;
        object = screenByteArray.readObject();

        var screen:Screen = new Screen(object.name);

        var elements:Array = object.elements;
        var interactions:Array = object.interactions;

        for (var i:int = 0; i < elements.length; i++) {

            var element:Element = new Element(elements[i].properties);
            screen.addElement(element);

        }

        ScreenManager.getInstance().addScreen(screen);

        for (var j:int = 0; j < interactions.length; j++) {

            var interaction:Interaction = new Interaction(screen.name, interactions[j].properties);
            InteractionManager.getInstance().addInteraction(interaction);
            screen.addInteraction(interaction);

        }


        return screen;

    }

































}
}
