class FonImage extends MovieClip{
	public function FonImage(){
		this._name = "FonImage";
		if(_root["CenterOfWorld"].abstractLaw!=undefined){
			_root["CenterOfWorld"].abstractLaw.fonImage = this;
		}
	}
}