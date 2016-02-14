class AbstractLawShadow extends AbstractLaw{ 
	
	public function forceIteration(){
		if(_global.player && _global.player._color.brightness>50) _global.player._color.brightness = 50;
		for(var i=0; i<this.length; i++){
			//trace("_global.player: "+_global.player._name+" Name("+i+"):" + this[i]._name);
			this.attractiveForce(this[i]);
			this.frictionForce(this[i]);
		}
	}
}
