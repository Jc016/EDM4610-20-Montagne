class Sky extends PanoramaElement {
  float SKY_PRECISION = 0.002;
  color[][] _skyTexture;
  color _cloudColor;
  Sky(Panorama paronama, int w, int h, color c, color cloudColor) {
    super(paronama, w, h, c); 
    _cloudColor = cloudColor;
    init();
  }

  private void init() {
    _skyTexture = new color[_width][_height];
  }

  public void update() {
  }
  private void generateSky() {
    _pg.loadPixels();
    noiseDetail(4);
    for (int i = 0; i < _width; i ++) {
      for (int j = 0; j< _height; j++) {
        _pg.pixels[i+j*_width] = lerpColor(_c, _cloudColor, noise(i*SKY_PRECISION, j*SKY_PRECISION));
      }
    }
    _pg.updatePixels();
  }

  public void  render() {
    _pg.beginDraw();  
    generateSky();
    _pg.endDraw();
    _ppp.addEffectToPipeline(AnimationEffects.FEEDBACK, new FeedbackEffect(_pg));   
    _ppp.addEffectToPipeline(AnimationEffects.ZOOM, new ZoomEffect(_pg));
  }
}