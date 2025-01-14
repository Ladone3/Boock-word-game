﻿class KeyObject extends PortalToLevel{
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
		this._visible = false;
		if(this._oldname.length>=4)this.targetAdditionalName = this._oldname.substr(4,this._oldname.length);
		this.getTargetObject();
	}

	public function doTeleportation(){
		//trace("I start "+targetObject);
		if(!this.targetObject)this.getTargetObject();
		if(this.targetObject){
			//trace("GoGoGo "+targetObject);
			this.targetObject.onKeyObject();
		}
	}
}