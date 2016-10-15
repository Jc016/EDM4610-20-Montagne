class Sun extends PanoramaElement {
  final float MIN_RADIUS = 300 * Utility.QUALITY_RENDER;
  final float MAX_RADIUS = 600* Utility.QUALITY_RENDER;
  final float MIN_DISTANCE = height / 2 - 200* Utility.QUALITY_RENDER;
  final float MAX_DISTANCE = height / 2 + 200* Utility.QUALITY_RENDER;
  float _radius;
  PVector _position;
  Sun(Panorama paronama, int w, int h, color c) {
    super(paronama, w, h, c); 
    init();
  }

  private void init() {
    _radius = random(MIN_RADIUS, MAX_RADIUS);
    _position = new PVector(random(width/2 - 300, width/2 + 300), random(0, MAX_DISTANCE));
    _ppp.addEffectToPipeline("chromatic abberation", new ChromaticAberrationEffect());
  }

  public void update() {
  }



  public void  render() {
    _pg.beginDraw();

    _pg.noStroke();
    _pg.fill(_c);
    _pg.noStroke();
    _pg.translate(_position.x, _position.y);
    _pg.ellipse(0, 0, _radius, _radius); 
    _pg.filter(BLUR, 5);
    _pg.filter(BLUR, 5);
    _pg.tint(255, 0.1);
    _pg.endDraw();
  }
}