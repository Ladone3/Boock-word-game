﻿class MenuItem extends MovieClip {
	private static var menuItemCount:Number=0;
	private var switcher:Switcher;
	private var menuCore:MenuCore;
	private var ID:Number=-1;
	private var jumpNumber:Number=0;
	
	public function get number():Number{
		return this.ID;
	}
	
	public static function get count():Number{
		return MenuItem.menuItemCount;
	}

	public function set mCore(menuCore:MenuCore){
		this.menuCore = menuCore;
	}
	
	public function get mCore():MenuCore{
		return this.menuCore;
	}
	
	public function	MenuItem(){
		stop();
		this.switcher = new Switcher(3,this,new Counter());
		this.ID = menuItemCount++;
		
		this.jumpNumber = int(this._name.substr(4,this._name.length));
		this._name = "MenuItem"+this.ID;
		if(_root["MenuCore"]){
			this.mCore =_root["MenuCore"];
			this.mCore.addItems(this);
		}
	} 
	
	public function onRollOver(){
		this.mCore.setFocusItem(this);
	}
	
	public function onPress(){
		this.preActivate();
	}
	
	public function onRelease(){
		this.activate();
	}
	
	public function catchFocus(){
		this.switcher.state = 3;
	}
	
	public function freeFocus(){
		this.switcher.state = 1;
	}
	
	public function preActivate(){
		this.switcher.state = 2;
	}
	
	public function activate(){
		MenuItem.menuItemCount = 0;
		_root.gotoAndStop(this.jumpNumber);
	}
}
