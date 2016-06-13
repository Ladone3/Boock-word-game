class ColorTransformer{
	private var object:MovieClip = null;
	private var col:Color = null;
	
	public function ColorTransformer(object){
		this.col = new Color(object);
		this.object = object;
	}
	
	public function getObject():MovieClip{
		return this.object;
	}
	
	public function setObject(object:MovieClip){
		this.col = new Color(object);
		this.object = object;
	}
	
	public function getColor():Color{
		return this.col;
	}
	
	public function getTransformObject():Object{
		return this.col.getTransform();
	}
	
	public function set red(red:Number){
		var curTransform = this.col.getTransform();
		curTransform.ra = red;
		this.col.setTransform(curTransform);
	}
	
	public function get red():Number{
		return this.col.getTransform().ra;
	}
	
	public function set green(green:Number){
		var curTransform = this.col.getTransform();
		curTransform.ga = green;
		this.col.setTransform(curTransform);
	}
	
	public function get green():Number{
		return this.col.getTransform().ga;
	}
	
	public function set blue(blue:Number){
		var curTransform = this.col.getTransform();
		curTransform.ba = blue;
		this.col.setTransform(curTransform);
	}
	
	public function get blue():Number{
		return this.col.getTransform().ba;
	}
	
	public function set alpha(alpha:Number){
		var curTransform = this.col.getTransform();
		curTransform.aa = alpha;
		this.col.setTransform(curTransform);
	}
	
	public function get alpha():Number{
		return this.col.getTransform().aa;
	}

	public function set brightness(b:Number){
		var curTransform = this.col.getTransform();
		curTransform.ra = b;
		curTransform.ga = b;
		curTransform.ba = b;
		this.col.setTransform(curTransform);
	}
	
	public function get brightness():Number{
		return this.col.getTransform().ba;
	}
}