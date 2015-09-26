class CameraBorder extends MovieClip{
	public function CameraBorder(){
		this._name = "CameraBorder";
		this._alpha=0;
		if(_global.abstractLaw){
			_global.abstractLaw.cameraBorder = this.getBounds(_root);
		}
	}
}