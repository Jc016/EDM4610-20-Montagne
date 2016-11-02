class Panorama extends Renderer {
  ArrayList <Renderer> _panoramaElements;
  ColorPalette _colorPalette;
  color _sunColor, _skyColor;
  PGraphics _mask;
  int _width, _height;
  boolean _mustTick = false;
  Panorama(int w, int h) {   
    super(w, h);
    _width =w;
    _height = h;
    init();
  }

  private void init() {
    _colorPalette = new ColorPalette();
    _skyColor = _colorPalette.fetchRandomColor();
    _panoramaElements = new ArrayList<Renderer>();
    _panoramaElements.add( new Sky(this, _pg.width, _pg.height, _skyColor, _colorPalette.fetchRandomColor()));
    _panoramaElements.add(new Mountains(this, _pg.width, _pg.height, _colorPalette.fetchRandomColor(), _sunColor, _skyColor));
    _mustTick = false;
    for (Renderer r : _panoramaElements) {
      r.render();
    }
    rendered = true;
  }

  public void update() {
  }

  public void processTick() {
    if (_mustTick) {
      int x1 = (int) random(0, _pg.width);
      int y1 = 0;

      int x2 = round(x1 + random(-17, 17));
      int y2 = round(random(-15, 15));

      int w = (int) random(35, 50);
      int h = _pg.height;
      _pg.copy(x1, y1, w, h, x2, y2, w, h);
      _mustTick = false;
    }
  }

  public void receivedTick() {
    _mustTick = true;
  }


  public void render() {
    _pg.beginDraw();
    for (Renderer r : _panoramaElements) {
      r.display(_pg);
    }
    _pg.endDraw();
  }

  public void display() {

    _pg.beginDraw();

    if (_mustTick) {
      processTick();
    }
    _pg.endDraw();
  }
}