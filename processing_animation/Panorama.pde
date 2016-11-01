class Panorama extends Renderer {
 ArrayList <Renderer> _panoramaElements;
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
    _panoramaElements = new ArrayList<Renderer>();
    _panoramaElements.add( new Sky(this, _pg.width, _pg.height, _skyColor, _colorPalette.fetchRandomColor()));
   // _panoramaElements.put(AnimationTargets.SUN, new Sun(this, _pg.width, _pg.height, _sunColor));

    _panoramaElements.add(new Mountains(this, _pg.width, _pg.height, _colorPalette.fetchRandomColor(), _sunColor, _skyColor));



    for (Renderer r : _panoramaElements) {
      r.render();
    }
  }

  public void update() {
  }


  public void render() {
    _pg.beginDraw();
    _pg.pushMatrix();
    for (Renderer r : _panoramaElements) {
      r.display(_pg);
    }
    _pg.endDraw();
    _pg.popMatrix();
  }
}