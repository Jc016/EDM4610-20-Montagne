class Mountains extends PanoramaElement {

  final float DEFAULT_MOUNTAIN_PRECISION = 0.005;
  final int DEFAULT_MOUNTAIN_DIVISION = 1200;
  final float DEFAULT_MOUNTAIN_SPEED = -0.05;
  final int DISTANCE_FROM_TOP_SCREEN = 0;
  final float MAX_HEIGHT = 1000* Utility.QUALITY_RENDER;


  float _precision = DEFAULT_MOUNTAIN_PRECISION;
  int _divisionsCount = DEFAULT_MOUNTAIN_DIVISION;

  PVector _subdivisionsSize;
  PShape _mesh;
  float[][] _heightMap;
  float _relativeHeight;
  float _relativeWidth;
  color _sunColor,_skyColor;


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

  public void render(){
    PImage mirrorMountain;
    clear();
    _pg.beginDraw();
    _pg.directionalLight(red(_sunColor), green(_sunColor), blue(_sunColor), 0, -1, 1);
    _pg.directionalLight(red(_sunColor), green(_sunColor), blue(_sunColor), 0, 0, -1);
    _pg.ambientLight(red(_skyColor), green(_skyColor), blue(_skyColor));
    _pg.directionalLight(255, 255, 255, 0, -1, 0);
    _pg.shininess(10.0);
    _pg.ambient(_skyColor);
    _pg.specular(_skyColor);
    _pg.fill(_c);
    _pg.noStroke();
    _pg.translate(_width/2, _height, 0);
    _pg.rotateX(PI * 0.333);
    _pg.translate(-_relativeWidth/2, -_relativeHeight/2, 0);
    generateMesh();
    _pg.endDraw();    
  }
}