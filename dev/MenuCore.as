class MenuCore extends MovieClip {
	private var items:Array;
	private var cur:MenuItem = null;
	private var curNumber = -1;
	private var minId:Number = 0;
	private var maxId:Number = 0;
	
	private var kUp:Number    = 38;
	private var kDown:Number  = 40;
	private var kLeft:Number  = 37;
	private var kRight:Number = 39;
	private var kActivate:Number = Key.SPACE;//Key.ENTER;
	
	public function addItems(item:MenuItem){
		this.curNumber = this.items.length;
		this.items[this.items.length] = item;
		this.setFocusItem(item);
	}
	
	public function getFocusItemNumber():Number{
		return this.curNumber;
	}
	
	public function getFocusItem():MenuItem{
		return this.cur;
	}
	
	public function setFocusItem(item:MenuItem){
		this.freeAll();
		for(var i=0; i<this.items.length; i++){	
			if(this.items[i]==item){
				this.cur=item;
				item.catchFocus();
				this.curNumber = i;
			}
		}
	}
	
	public function setFocusItemByNumber(item:Number){
		this.freeAll();
		if(0<=item<this.items.length){
			this.cur=this.items[item];
			this.items[item].catchFocus();
			this.curNumber = item;
		}
	}
	
	public function	MenuCore(){
		_root._alpha = 100;
		this.items = new Array();
		this._name = "MenuCore";
		for(var i=0; i<MenuItem.count; i++){	
			if(_root["MenuItem"+i]){
				addItems(_root["MenuItem"+i]);
			}
		}
		
		Key.addListener(this);
	} 
		
	public function onKeyUp(){
		if(Key.getCode() == this.kActivate) this.cur.activate();
	}
	
	public function onKeyDown(){
		if((Key.getCode() == this.kUp) || (Key.getCode() == this.kRight)) this.nextItem();
		if((Key.getCode() == this.kLeft) || (Key.getCode() == this.kDown)) this.prevItem();
		if(Key.getCode() == this.kActivate) this.cur.preActivate();
	}
		
	public function freeAll(){
		for(var i=0; i<this.items.length; i++){		
			items[i].freeFocus();
		}
		this.cur = null;
		this.curNumber = -1;
	}
	
	public function nextItem(){
		this.setFocusItemByNumber(this.getFocusItemNumber()+1>=items.length ? 0 : this.getFocusItemNumber()+1);
	}
	
	public function prevItem(){
		this.setFocusItemByNumber(this.getFocusItemNumber()-1<0 ? items.length-1 : this.getFocusItemNumber()-1);
	}
}
