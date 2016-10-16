class Panorama extends Renderer {
  HashMap<String, Renderer> _panoramaElements;
  ColorPalette _colorPalette;
  color _sunColor, _skyColor;
  PGraphics _mask;
  int _width, _height;
  Panorama(int w, int h) {   
    super(w, h);
    _width =w;
    _height = h;
    init();
  }

  private void init() {
    _colorPalette = new ColorPalette();
    _sunColor = _colorPalette.fetchRandomColor();
    _skyColor = _colorPalette.fetchRandomColor();
    _panoramaElements = new HashMap<String, Renderer>();
    _panoramaElements.put(AnimationTargets.SKY, new Sky(this, _pg.width, _pg.height, _skyColor, _colorPalette.fetchRandomColor()));
    _panoramaElements.put(AnimationTargets.SUN, new Sun(this, _pg.width, _pg.height, _sunColor));
    _panoramaElements.put(AnimationTargets.MOUNTAINS, new Mountains(this, _pg.width, _pg.height, _colorPalette.fetchRandomColor(), _sunColor, _skyColor));
    _ppp.addEffectToPipeline(AnimationEffects.ZOOM, new ZoomEffect(_pg));
    _ppp.addEffectToPipeline("Oval Mask", new OvalMaskEffect());
    for (Renderer r : _panoramaElements.values()) {
      r.render();
    }
  }

  public void update() {
  }

  public void processAction(AnimationAction animationAction) {
    if (animationAction.getTarget()== AnimationTargets.PANORAMA) {
      _ppp.getEffect(animationAction.getEffect()).processState(animationAction.getState());
    }
  }

  public void render() {
    _pg.beginDraw();
    _pg.background(255);
    for (Renderer r : _panoramaElements.values()) {
      r.display(_pg);
    }
    _pg.endDraw();
    //image(_pg,0,0);
  }
}