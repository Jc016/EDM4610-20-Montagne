class Panorama extends Renderer {
  HashMap<String,Renderer> _panoramaElements;
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
    _panoramaElements = new HashMap<String,Renderer>();
    _panoramaElements.put(AnimationTargets.SKY,new Sky(this, _pg.width, _pg.height, _skyColor, _colorPalette.fetchRandomColor()));
    _panoramaElements.put(AnimationTargets.SUN,new Sun(this, _pg.width, _pg.height, _sunColor));
    _panoramaElements.put(AnimationTargets.MOUNTAINS,new Mountains(this, _pg.width, _pg.height, _colorPalette.fetchRandomColor(), _sunColor, _skyColor));
    _ppp.addEffectToPipeline("Oval Mask",new OvalMaskEffect());
    generateMask();
    for (Renderer r : _panoramaElements.values()) {
      r.render();
    }
  }

  public void update() {
    for (Renderer r : _panoramaElements.values()) {
      r.update();
    }
  }

  public void processAction(AnimationAction animationAction){
    
  }
  private void generateMask() {
    _mask = createGraphics(_width, _height);
    _mask.beginDraw();
    _mask.background(255);
    _mask.fill(0);
    _mask.ellipse(_width/2, _height/2, width, height);
    _mask.endDraw();
  }

  public void render() {
    _pg.beginDraw();
    _pg.background(255);
    _pg.scale(1);
    for (Renderer r : _panoramaElements.values()) {
      r.display(_pg);
    }
    _pg.endDraw();
    //image(_pg,0,0);
  }
}