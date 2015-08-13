class CameraBorder extends MovieClip{
	public function CameraBorder(){
		this._name = "CameraBorder";
		this._alpha=0;
		if(_root["CenterOfWorld"].abstractLaw!=undefined){
			_root["CenterOfWorld"].abstractLaw.cameraBorder = this.getBounds(_root);
		}
	}
}