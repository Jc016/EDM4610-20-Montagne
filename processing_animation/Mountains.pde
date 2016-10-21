class Mountains extends PanoramaElement {

  final float DEFAULT_MOUNTAIN_PRECISION = 0.006;
  final int DEFAULT_MOUNTAIN_DIVISION = 1400;
  final float DEFAULT_MOUNTAIN_SPEED = -0.05;
  final int DISTANCE_FROM_TOP_SCREEN = 0;
  final float MAX_HEIGHT = 400* Utility.QUALITY_RENDER;
  final int DIM_LIGHTS_FACTOR = 60;


  float _precision = DEFAULT_MOUNTAIN_PRECISION;
  int _divisionsCount = DEFAULT_MOUNTAIN_DIVISION;

  PVector _subdivisionsSize;
  PShape _mesh;
  float[][] _heightMap;
  float _relativeHeight;
  float _relativeWidth;
  color _sunColor, _skyColor;


  Mountains(Panorama panorama, int w, int h, color c, color sunColor, color skyColor) {
    super(panorama, w, h, c);
    _relativeHeight = h*1;
    _relativeWidth = w*2;
    _sunColor =sunColor;
    _skyColor =skyColor;
    init();
  }

  private void generateMesh() {

    for (int i = 0; i < _divisionsCount -1; i++) {
      _pg.beginShape(TRIANGLE_STRIP);   
      for (int j=0; j < _divisionsCount; j++) {
        _pg.vertex(j* _subdivisionsSize.x, i* _subdivisionsSize.y, _heightMap[j][i]);
        _pg.vertex(j* _subdivisionsSize.x, (i +1)* _subdivisionsSize.y, _heightMap[j][i+1]);
      }
      _pg.endShape();
    }
  }

  private void  generateHeightMap() {
    noiseSeed((long)random(10000000));
    _heightMap= new float[_divisionsCount][_divisionsCount];
    noiseDetail(18);
    for (int i =0; i < _divisionsCount; i++) {
      for (int j =0; j < _divisionsCount; j++) {
        _heightMap[i][j] = map(noise(i*_precision, j*_precision), 0, 1, -MAX_HEIGHT, MAX_HEIGHT);
      }
    }
  }

  private void init() {
    calculateSubdivisionsSize();
    generateHeightMap();
  }

  public void calculateSubdivisionsSize() {
    _subdivisionsSize = new PVector(_relativeWidth/ _divisionsCount, _relativeHeight/_divisionsCount);
  }

  public void render() {
    _pg.beginDraw();
    _pg.directionalLight(red(_sunColor)-DIM_LIGHTS_FACTOR, green(_sunColor)-DIM_LIGHTS_FACTOR, blue(_sunColor)-DIM_LIGHTS_FACTOR, 0, -1, 1);
    _pg.directionalLight(red(_sunColor)-DIM_LIGHTS_FACTOR, green(_sunColor)-DIM_LIGHTS_FACTOR, blue(_sunColor)-DIM_LIGHTS_FACTOR, 0, 0, -1);
    _pg.ambientLight(red(_skyColor)-DIM_LIGHTS_FACTOR, green(_skyColor)-DIM_LIGHTS_FACTOR, blue(_skyColor)-DIM_LIGHTS_FACTOR);
    _pg.directionalLight(255, 255, 255, 0, -1, 0);
    _pg.shininess(10.0);
    _pg.ambient(_skyColor);
    _pg.specular(_skyColor);
    _pg.fill(_c);
    _pg.noStroke();
    _pg.translate(_width/2, _height, 0);
    _pg.rotateX(PI * 0.5);
    _pg.translate(-_relativeWidth/2, -_relativeHeight/2, 0);
    generateMesh();
    _pg.endDraw();
    _pg.beginDraw();
    _pg.endDraw();
    _ppp.addEffectToPipeline(AnimationEffects.FEEDBACK, new FeedbackEffect(_pg));
  }
}