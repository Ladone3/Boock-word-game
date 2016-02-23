class AbstractLawShadow extends AbstractLaw{ 
	
	public function forceIteration(){
		super.forceIteration();
		if(_global.player && _global.player._color.brightness>50) _global.player._color.brightness = 50;
	}

	// Переопределение
	public function cameraStoper(TARGET){
		var pbounds = TARGET.getBounds(_root);
		if(pbounds.xMin<stageBounds.xMin){
			TARGET._x += stageBounds.xMin - pbounds.xMin;
		}
		if(pbounds.xMax>stageBounds.xMax){
			TARGET._x += stageBounds.xMax - pbounds.xMax;
		}
		if(pbounds.yMin<stageBounds.yMin){
			TARGET._y += stageBounds.yMin - pbounds.yMin;
		}
		if(pbounds.yMax>stageBounds.yMax){
			TARGET._y += stageBounds.yMax - pbounds.yMax;
		}
	}	
}
