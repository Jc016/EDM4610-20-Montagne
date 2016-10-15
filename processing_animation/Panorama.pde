class Panorama extends Renderer {
  ArrayList<Renderer> _panoramaElements;
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
    _panoramaElements.add(new Sky(this, _pg.width, _pg.height, _skyColor, _colorPalette.fetchRandomColor()));
    _panoramaElements.add(new Sun(this, _pg.width, _pg.height, _sunColor));
    _panoramaElements.add(new Mountains(this, _pg.width, _pg.height, _colorPalette.fetchRandomColor(), _sunColor, _skyColor));
    generateMask();
    for (Renderer r : _panoramaElements) {
      r.render();
    }
  }

  public void update() {
    for (Renderer r : _panoramaElements) {
      r.update();
    }
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
    PGraphics panoramaRender = createGraphics(_width, _height);
    PImage bufferImage;
    _pg.beginDraw();
    _pg.background(0);
    fill(#FFFFFF);
    rect(0, 0, width, height);
    panoramaRender.beginDraw();

    for (Renderer r : _panoramaElements) {
      image(r.getImage(), 0, 0);
    }
    panoramaRender.endDraw();
    bufferImage = Utility.convertGraphicToImage(panoramaRender);
    image(bufferImage, 0, 0);
    _pg.endDraw();
  }
}