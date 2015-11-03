﻿class Point{
	public var x:Number;
	public var y:Number;
	public var left:Boolean = false;
	public var right:Boolean = false;
	public var up:Boolean = false;
	public var down:Boolean = false;
	public var object:GameObject = null;
	
	public function Point(x:Number, y:Number, up:Boolean, down:Boolean, left:Boolean, right:Boolean, object:GameObject){
		this.x = x;
		this.y = y;
		this.left = left;
		this.right = right;
		this.up = up;
		this.down = down;
		this.object = object;
	}
}
