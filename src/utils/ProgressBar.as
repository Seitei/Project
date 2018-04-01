package utils
{
    import starling.display.Quad;
    import starling.display.Sprite;

    public class ProgressBar extends Sprite
    {
        private var _bar:Quad;
        private var _maxWidth:int;
        private var _color:uint;
        private var _ratio:Number;

        public function ProgressBar(maxWidth:int, color:uint)
        {
            _maxWidth = maxWidth;
            _color = color;
        }

        public function init():void
        {
            _bar = new Quad(_maxWidth, 3);
            _bar.scaleX = 0;
            _bar.color = _color;
            addChild(_bar);
            _ratio = 0;
        }

        public function setRatio(value:Number):void
        {
            _ratio = value;
            _bar.scaleX = _ratio;

            if(_ratio == 1){
                reset();
                hide();
            }
        }

        private function reset():void {
            _ratio = 0;
            _bar.scaleX = 0;
            removeChild(_bar);
        }

        private function hide():void {
            removeChild(_bar);
        }
    }
}