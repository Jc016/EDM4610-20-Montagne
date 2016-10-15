class MainAnimator{
  
  
  //Class global variables
  
  PGraphics _pg;
  Panorama _panorama;
  int _w, _h;
  
  
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
  
  public void updateAndDisplay(){
    update();
    display();
  }
  
  
}