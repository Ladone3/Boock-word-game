class CenterOfWorldShadow extends CenterOfWorld {

	public function createAbstractLaw() {
		_global.abstractLaw = new AbstractLawShadow();
	}

}
