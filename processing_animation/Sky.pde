class Sky extends PanoramaElement {
  color _cloudColor;
  Sky(Panorama paronama, int w, int h, color c, color cloudColor) {
    super(paronama, w, h, c); 
    _cloudColor = cloudColor;
  }


  public void update() {
  }

  private PImage fetchFromFolder() {
    PImage img;
    File folder = new File(dataPath("sky"));
    ArrayList<String> filteredFileNames = new ArrayList<String>();
    String fileName = "";
    if (folder != null) {
      for (File file : folder.listFiles()) {
        if (file.getName().endsWith(".jpg")) {
          filteredFileNames.add(file.getName());
        }
      }
      int fileNum =(int)random(0, filteredFileNames.size());
      fileName = dataPath("sky")+"/"+filteredFileNames.get(fileNum);
    }
    img =loadImage(fileName);
    return img;
  } 

  public void  render() {
    PImage bufferImage =  fetchFromFolder();
    PImage img = createImage(width, height, ARGB);
    img= bufferImage.get((int)random(0, bufferImage.width - width), 0, width, height);


    _pg.beginDraw();
    _pg.translate(0, 0);
    _pg.scale(2);
    _pg.image(img, 0, 0);
    _pg.pushStyle();
    _pg.tint(_cloudColor, 100);
    _pg.image(img, 0, 0);
    _pg.popStyle();
    _pg.endDraw();
    _ppp.addEffectToPipeline(AnimationEffects.FEEDBACK, new FeedbackEffect(_pg));
  }
}