public abstract class Renderer {

  protected PGraphics _pg;
  protected PostProcessPipeline _ppp;

  int _width, _height;
  Renderer(int w, int h) {
    _width =w;
    _height = h;
    _ppp = new PostProcessPipeline();
    clear();
  }
  
  protected void clear(){
    _pg= createGraphics(_width, _height,P3D);
  }

  public abstract void update();
  public abstract void render();
  public void display (PGraphics parent){
    PGraphics pipelineGraphic = getCopyGraphics();
    _ppp.setPipelineTo(pipelineGraphic);
    parent.image(pipelineGraphic.get(),0,0);
  }

  public PImage getImage() {
    return _pg.get();
  }

  public PGraphics getGraphics() {
    return _pg;
  }
  
  public PGraphics getCopyGraphics(){
    
    PGraphics copyGraphic = createGraphics(_width, _height);
    copyGraphic.beginDraw();
    _pg.loadPixels();
    copyGraphic.loadPixels();
    arrayCopy(_pg.pixels, copyGraphic.pixels);
    copyGraphic.updatePixels();
    copyGraphic.endDraw();
    return copyGraphic;
    
  }

  public void updateAndDisplay() {
    update();
    render();
  }
}