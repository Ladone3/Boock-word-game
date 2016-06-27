class KeySetter extends MovieClip{
	private var buttonName: String;
	
	public function KeySetter(){
		this._name = "KeySetter"
		this._visible = false;
		Key.addListener(this);
	} 
	
	public function onKeyDown(){
		if(this._visible){
			_global[this.buttonName] = Key.getCode();
			trace(_global[this.buttonName]);
			resetButtons();
		}
	}
	
	public function resetButtons(){
		this._visible = false;
		_root["Up"]._alpha = 100;
		_root["Down"]._alpha = 100;
		_root["Left"]._alpha = 100;
		_root["Right"]._alpha = 100;
		_root["Blow"]._alpha = 100;
		_root["Jump"]._alpha = 100;
	}
	
	public function catchMe(buttonName){
		this.buttonName = buttonName;
		this._visible = true;
		_root["Up"]._alpha = (buttonName === "Up"? 100: 30);
		_root["Down"]._alpha = (buttonName === "Down"? 100: 30);
		_root["Left"]._alpha = (buttonName === "Left"? 100: 30);
		_root["Right"]._alpha = (buttonName === "Right"? 100: 30);
		_root["Blow"]._alpha = (buttonName === "Blow"? 100: 30);
		_root["Jump"]._alpha = (buttonName === "Jump"? 100: 30);
	}
}