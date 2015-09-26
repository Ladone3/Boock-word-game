class FonImage extends MovieClip{
	public function FonImage(){
		this._name = "FonImage";
		if(_global.abstractLaw){
			_global.abstractLaw.fonImage = this;
		}
	}
}