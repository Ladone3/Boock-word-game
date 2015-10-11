class ForegroundObject extends GameObject{
	private var depth1:Number;
	private var depth2:Number;
	
	public function ForegroundObject(){
		this.calculateObject = false;
		this.depth1=_root.getNextHighestDepth();
		this.swapDepths(depth1);
		this.depth2=_root.getNextHighestDepth();
		this.swapDepths(depth2);
		this.swapDepths(_root.getNextHighestDepth());
	}
	
	//Переопределение
	public function onEnterFrame(){
		//super.onEnterFrame();
		this.doSomething();
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return false;
	}
	
	// Переопределение
	public function deinit(){
		return true;
	}
	
	public function doSomething(){
		for(var i=0; i<_global.abstractLaw.length; i++){
			var curObject = _global.abstractLaw[i];
			if(curObject.mov && this.hitTest(curObject) && curObject.getDepth()>this.getDepth()){
				if(curObject instanceof Ladone3Player){
					this.swapDepths(curObject);
					curObject.getHandL().swapDepths(depth2);
					curObject.getHandR().swapDepths(depth1);
					curObject.swapDepths(curObject.getHandL());
				}else{
					this.swapDepths(curObject);
				}
			}
		}
	}
}