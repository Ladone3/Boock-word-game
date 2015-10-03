class ForegroundObject extends GameObject{
	private var depth1:Number;
	private var depth2:Number;
	
	public function ForegroundObject(){
		this.depth1=_root.getNextHighestDepth();
		this.swapDepths(depth1);
		this.depth2=_root.getNextHighestDepth();
		this.swapDepths(depth2);
		this.swapDepths(_root.getNextHighestDepth());
	}
	
	//Переопределение
	public function onEnterFrame(){
		super.onEnterFrame();
		this.onEnterFrameCatchPlayer();
	}
	
	// Переопределение
	public function takeObject(object:GameObject):Boolean{
		return false;
	}
	
	// Переопределение
	public function deinit(){
		return true;
	}
	
	//Переопределение
	public function onEnterFrameCatchPlayer(){
		if(_global.player!=null){
				if(this.hitTest(_global.player)&&(_root._alpha>=100)){
					this.doSomething();
				}
		}	
	}

	public function doSomething(){
		if(_global.player.getDepth()>this.getDepth()){
			if(_global.player instanceof Ladone3Player){
				this.swapDepths(_global.player);
				_global.player.getHandL().swapDepths(depth2);
				_global.player.getHandR().swapDepths(depth1);
				_global.player.swapDepths(_global.player.getHandL());
			}else{
				this.swapDepths(_global.player);
			}
		}
	}
	
	// Переопределение
	public function getType():Number{
		return 101;
	}
}