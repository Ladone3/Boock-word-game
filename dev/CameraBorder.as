class CameraBorder extends MovieClip{
	public function CameraBorder(){
		this._name = "CameraBorder";
		this._visible=false;
		if(_global.abstractLaw){
			_global.abstractLaw.cameraBorder = this.getBounds(_root);
		}
	}
}