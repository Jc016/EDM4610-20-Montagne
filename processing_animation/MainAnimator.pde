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
    _pg = createGraphics(_w,_h);
    _panorama = new Panorama((int)(_w*Utility.QUALITY_RENDER),(int)(_h*Utility.QUALITY_RENDER));
  }
  
  public void update(){
    _panorama.update();
  }
  
  public void display(){
    background(0);
    scale(Utility.QUALITY_RENDER);
    
    _panorama.render();
  /*  _pg.beginDraw();
    _pg.translate(_w/2,_h/2);
    
    _pg.image(_panorama.getImage(),0,0);
    _pg.endDraw();
    image(_pg,0,0);*/
  }
  
  public void updateAndDisplay(){
    background(255);
    update();
    display();
  }
  
  
}