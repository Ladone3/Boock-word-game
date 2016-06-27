class ContinousCounter extends MovieClip{
	public function ContinousCounter(){
		
	}
	
	public function onEnterFrame(){
		trace(_global.continous);
		 
		this['CC1']._visible = (_global.continous == 1? true: false);
		this['CC2']._visible = (_global.continous == 2? true: false);
		this['CC3']._visible = (_global.continous == 3? true: false);
	
	}
}