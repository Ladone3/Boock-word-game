class MenuCore extends MovieClip {
	private var idCounter:Number = 0;
	private var items:Array = new Array();
	private var cur:MenuItem = null;
	private var counter:Counter;
	private var minId:Number = 0;
	private var maxId:Number = 0;
	
	private var kUp:Number    = 38;
	private var kDown:Number  = 40;
	private var kLeft:Number  = 37;
	private var kRight:Number = 39;
	private var kActivate:Number = Key.SPACE;//Key.ENTER;
	
	public function getNewId(){
		return idCounter++;
	}
	
	public function addItems(item:MenuItem){
		this.items[this.items.length] = item;
	}
	
	public function getFocusItem():MenuItem{
		return this.cur;
	}
	
	public function setFocusItem(item:MenuItem){
		this.freeAll();
		this.cur = item;
		item.catchFocus();
	}
	
	public function	MenuCore(){
		this._name = "MenuCore";
		this.counter = new Counter();
		//this.minId =
		for(var i=0; i<MenuItem.count || i<idCounter; i++){	
			if(_root["MenuItem"+i]){
				var index = this.getNewId();
				items[index] = _root["MenuItem"+i];
				items[index].mCore = this;
				items[index].ID=index;
			}
		}
		this.setFocusItem(items[0]);
	} 
	
	public function onEnterFrame() {
		if(!this.counter.notOver){
			if(Key.isDown(kUp)||Key.isDown(kRight)) this.nextItem();
			if(Key.isDown(kLeft)||Key.isDown(kDown)) this.prevItem();
			if(Key.isDown(kActivate)) this.cur.activate();
		}
		this.counter.iterateCounter();
	}
	
	public function freeAll(){
		for(var i=0; i<MenuItem.count || i<idCounter; i++){		
			items[i].freeFocus();
		}
	}
	
	public function nextItem(){
		setFocusItem(this.cur.number+1>=items.length ? items[0] : items[this.cur.number+1]);
		this.counter.delay=10;
	}
	
	public function prevItem(){
		setFocusItem(this.cur.number-1<0 ? items[items.length-1] : items[this.cur.number-1]);
		this.counter.delay=10;
	}
}
