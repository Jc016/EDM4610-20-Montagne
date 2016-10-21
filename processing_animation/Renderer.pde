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

  protected void clear() {
    _pg= createGraphics(_width, _height, P3D);
  }

  public abstract void update();
  public abstract void render();
  public void display (PGraphics parent) {
   _ppp.setPipelineTo(_pg);
    parent.image(_pg, 0, 0);
  }


  public PImage getImage() {
    return _pg;
  }

  public PGraphics getGraphics() {
    return _pg;
  }

  public void updateAndDisplay() {
    update();
    render();
  }
}