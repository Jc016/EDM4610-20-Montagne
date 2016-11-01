import java.io.*;
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
  }


  private PImage fetchFromFolder() {
    PImage img;
    File folder = new File(dataPath("panoramas"));
    ArrayList<String> filteredFileNames = new ArrayList<String>();
    String fileName = "";
    if (folder != null) {
      for (File file : folder.listFiles()) {
        if (file.getName().endsWith(".png")) {
          filteredFileNames.add(file.getName());
        }
      }
      int fileNum =(int)random(0, filteredFileNames.size());
      fileName = dataPath("panoramas")+"/"+filteredFileNames.get(fileNum);
    }
    img =loadImage(fileName);
    return img;
  }


  public void render() {
    PImage bufferImage =  fetchFromFolder();
    PImage img = createImage(width,height,ARGB);
    img = bufferImage.get((int)random(0,bufferImage.width - width),0,width,height);
    
    
    _pg.beginDraw();
    _pg.translate(0, height - 600);
    _pg.image(img, 0, 0);
    _pg.pushStyle();
    _pg.tint(_skyColor, 200);
    _pg.image(img, 0, 0);
    _pg.popStyle();
    _pg.endDraw();
  }
}