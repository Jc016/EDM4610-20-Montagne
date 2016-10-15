class MainAnimator{
  
  
  //Class global variables
  private final float MIN_ACTION_DURATION = 3;
  private final float MAX_ACTION_DURATION = 15;
  PGraphics _pg;
  Panorama _panorama;
  int _w, _h;
  Timeline _timeline;

  
  
  MainAnimator(int w, int h){
    _w =w;
    _h =h;
    reset();
  }
  
  public void  triggerMainTick(){
  
  }
  
  public void reset(){
    background(0);
    _pg = createGraphics(_w,_h);
    _panorama = new Panorama(_w,_h);
    if(_timeline == null){
      _timeline = Timeline.getInstance();
    }
    _timeline.setMainAnimator(this);
    initAnimationActions();
    _timeline.setNewBpm(90);
  }
  
  
  public void update(){
    _panorama.update();
  }
  
  public void processAction(AnimationAction animationAction){
    _panorama.processAction(animationAction);
  }
  
  public void display(){
    _pg.beginDraw();
    _pg.background(255);
    _pg.noStroke();
    _pg.tint(255,90);
    _panorama.render();
    _panorama.display(_pg);
    _pg.endDraw();
    image(_pg,0,0);
  }
  
  private void initAnimationActions(){
    int start = 5;
    _timeline.addAction(start,new AnimationAction(AnimationTargets.PANORAMA,AnimationEffects.ZOOM,true));
    _timeline.addAction(start + (int)random(MIN_ACTION_DURATION,MAX_ACTION_DURATION),new AnimationAction(AnimationTargets.PANORAMA,AnimationEffects.ZOOM,true));
  }
  
  public void updateAndDisplay(){
    update();
    display();
  }
  
  
}