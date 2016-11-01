class MainAnimator {


  //Class global variables
  private final float MIN_ACTION_DURATION = 3;
  private final float MAX_ACTION_DURATION = 15;
  private final int MIN_OCCURENCES_ANIMATIONS = 20;
  private final int MAX_OCCURENCES_ANIMATIONS = 30;
  private final int START_TIME_EFFECT = 6;

  PGraphics _pg;
  Panorama _panorama;
  int _w, _h;
  Timeline _timeline;
  Esprit _esprit;
  int _opacity;



  MainAnimator(int w, int h) {
    _w =w;
    _h =h;
    reset();
  }

  public void  triggerMainTick() {
  }

  public void reset() {
    background(0);
    _pg = createGraphics(_w, _h);
    _opacity = 255;
    _panorama = new Panorama(_w, _h);
    _esprit= new Esprit();
    if (_timeline == null) {
      _timeline = Timeline.getInstance();
      _timeline.setMainAnimator(this);
    } else {
      _timeline.reset();
    }
    _timeline.setNewBpm(60);
  }


  public void update() {
    _esprit.update();
    if (_timeline.getPosition() > _timeline.getLength()) {
      reset();
    }
  }

  public void processTick() {
    _panorama.receivedTick();
    _esprit.receiveTick();
  }

  public void setBpm(int bpm) {
    if (bpm != _timeline.getBpm() ) {
      bpm = bpm  > 0 ? bpm:1;
      _timeline.setNewBpm(bpm);
    }
  }


  public void display() {
    _panorama.render();
    pushStyle();
    tint(255, _opacity);
    image(_panorama.getGraphics(), 0, 0);
    popStyle();
    pushMatrix();
    translate(0,-100);
    image(_esprit.getContext().get(), 0, 0);
    popMatrix();
    
  }


  public void updateAndDisplay() {
    update();
    display();
  }
}