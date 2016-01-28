class AreaObject extends MovieClip{
	public function AreaObject(){
		this._visible = false;

		for(var i=0; i<_root.length; i++){	
			var object = _root[i];
			if(object && object instanceof GameObject){
				if(object.areaXName 
				&& object.areaXName==this._name
				) object.compileBounds(this);
			}
		}
	}
}