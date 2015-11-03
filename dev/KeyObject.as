class KeyObject extends PortalToLevel{
	private var targetAdditionalName:String;
	private var targetObject:TargetObject;
	
	public function getTargetObject():TargetObject{
		if(!this.targetObject && _global.abstractLaw){
			for(var i=0; i<_global.abstractLaw.length; i++){
				if(_global.abstractLaw[i].additionalName 
				&& _global.abstractLaw[i].additionalName===this.targetAdditionalName){
					this.targetObject = _global.abstractLaw[i];
				} 
			}
		}
		return this.targetObject;
	}
	
	public function KeyObject(){
		this.targetAdditionalName = this.lastname.substr(4,this.lastname.length);
		this.getTargetObject();
	}

	public function doTeleportation(){
		trace("I start "+targetObject);
		if(!this.targetObject)this.getTargetObject();
		if(this.targetObject){
			trace("GoGoGo "+targetObject);
			this.targetObject.onKeyObject();
		}
	}
}