class NextStage extends GameObject{
	// Переопределение
	public function onEnterFrame(){
		var d:Number = Math.abs(law.findObject(this, 200));
		if(d<100&&d>0){ 
			
			_root._x = 0;
			_root._y = 0;
			law.IndicatorPlace._x=200;
			law.IndicatorPlace._y=70;
			law.borderX1= law.widthWindow*(2/5);
			law.borderX2= law.widthWindow*(3/5);
			law.borderY1= law.heightWindow*(2/5);
			law.borderY2= law.heightWindow*(3/5);
			
			_root["CenterOfWorld"].goToAndStopToNextFrame();
			
			//_root.nextFrame();
			//_root.play();
			
		}
	}
}