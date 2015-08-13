class RandomColor extends MovieClip { 
	// X кссрдината 
	public var _x:Number; 
	// Y кссрдината 
	public var _y:Number; 
	// Начальные значения кссрдинат 
	var initX:Number; 
	var initY:Number; 
	// Цветсвсй сбъект 
	private var col:Color; 
	// Начальный угол 
	private var a:Number; 
	private var increment:Number; 
	function RandomColor() {
		// Позиционируем клип случайным образом 
		this._x = Math.random() * Stage.width; 
		this._y = Math.random() * Stage.height; 
		// Сохраняем начальные значения кссрдинат 
		initX = this._x; 
		initY = this._y;
		// Инициализируем сбъект Color (this это ссыпка на 
		// объект, с которым связывается класс)
		col = new Color (this);

		// Применяем окрашивание
		col.setRGB(Math.random()*0xFFFFFF) ;
		// Задаем случайный угол
		a = Math.random() * 2 * Math.PI;
		// Приращение угла
		increment = Math.random() * 0.5 + 0.1;
	}
	// Определяем обработчик onEnterFrame() 
	public function onEnterFrame() {
		// Реализация перемещения пс окружности
		_x = initX + 25 * Math.sin(a);
		_y = initY + 25 * Math.cos(a); 
		col.setRGB(Math.random()*0xFFFFFF) ;
		// Приращение аргумента
		a += increment;
		if(a>2*Math.PI){
			a=0;
		}
	}
}
