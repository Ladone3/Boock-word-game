class FonImage extends MovieClip{
	public static var fonImageCount:Number=0;
	
	public var xDelay = 0.8;
	public var yDelay = 0.5;
	
	public function FonImage(){
		this._name = "fonImage"+(fonImageCount);
		fonImageCount++;
		if(_global.abstractLaw){
			_global.abstractLaw.fonImages.push(this);
		}
	}
}