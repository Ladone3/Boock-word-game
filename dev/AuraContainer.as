class AuraContainer extends MovieClip{
	private var parent:MovieClip;
	private var chield:MovieClip;
	
	public function AuraContainer(parent:MovieClip){
		this.parent = parent;
		this.chield = null;
		//addEventListener (Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function useAura(aura:String){
		this.parent = parent;
		_root.attachMovie(aura, aura+parent._name, _root.getNextHighestDepth());
		this.chield = _root[aura+parent._name];
	}
	
	public function handIteration(){
		this.chield._x = this.parent._x;
		this.chield._y = this.parent._y;
	}
}