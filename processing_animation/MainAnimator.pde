class MainAnimator {


  PGraphics _pg;
  Panorama _panorama;
  int _w, _h;
  Timeline _timeline;
  Esprit _esprit;
  int _opacity;



  MainAnimator(int w, int h) {
    _w =w;
    _h =h;
    _timeline = new Timeline(this);
    _esprit= new Esprit();
    reset();
  }

  public void  triggerMainTick() {
  }

  public void reset() {
    background(0);
    _pg = createGraphics(_w, _h);
    _opacity = 255;
    _panorama = new Panorama(_w, _h);
    _panorama.render();
    _timeline.setNewBpm(90);
  }


  public void update() {

    _esprit.update();
    if (_timeline.getPosition() > _timeline.getLength()) {
      _esprit.tryToBeAngry();
      reset();
    }
  }

  public void processTick() {
   println( _timeline.getBpm());
    _panorama.receivedTick();
    _esprit.receiveTick();
  }

  public void setBpm(int bpm) {
    if (bpm != _timeline.getBpm() ) {
      println("changing bom");
      _timeline.setNewBpm(bpm);
      _esprit.tryToBeAngry();
    }
  }


  public void display() {
    _panorama.display();
    pushStyle();
    tint(255, _opacity);
    image(_panorama.getGraphics(), 0, 0);
    popStyle();
    pushMatrix();
    translate(0, -100);
    pushStyle();
    tint(255,180);
    image(_esprit.getContext().get(), 0, 0);
    popStyle();
    popMatrix();
  }


  public void updateAndDisplay() {
    _timeline.processTimer();
    if (_esprit.getState() == EspritEmotion.ANGRY) {
      _panorama.receivedTick();
    }
    update();
    display();
  }
}