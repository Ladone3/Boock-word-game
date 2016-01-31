class AreaObject extends MovieClip{
	public var isArea:Boolean = true;
	
	public function AreaObject(){
		this._visible = false;
		for(var i in _root){	
			var object = _root[i];
			if(object 
			&& i.indexOf("gameObject")!=-1 
			&& object.areaNeeded
			&& this.hitTest(object)){//&& object instanceof GameObject){
				object.compileBounds(this);
			}
		}
	}
}