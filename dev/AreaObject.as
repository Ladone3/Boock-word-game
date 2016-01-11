class AreaObject extends MovieClip{
	public function AreaObject(){
		this._visible = false;

		for(var i=0; i<GameObject.count; i++){	
			var object = _root["gameobject"+i];
			if(object){
				if(object.areaXName 
				&& object.areaXName==this._name 
				/*&& _global.abstractLaw[i].compileBounds*/) object.compileBounds(this);
			}
		}
	}
}