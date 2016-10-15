//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class ZoomEffect extends PostProcessEffect implements ITimelineAnimation {
  final float MIN_SCALE = 1.1;
  final float MAX_SCALE = 2;
  float _scaleFactor = 1.0;
  PVector _translate;
  PVector _sceneSize;
  
  ZoomEffect(PGraphics c){
    super();
    _isActive =false;
    _sceneSize = new PVector(c.width,c.height);
  }

  public void applyEffectOn(PGraphics context) {
    if(_isActive){
        PImage bufferImage = context.get();
        context.beginDraw();
        context.scale(_scaleFactor);
        context.translate(_translate.x,_translate.y);
        context.endDraw();  
    }


  }
  

  public void begin(){
    _scaleFactor = random(MIN_SCALE,MAX_SCALE);
    _translate =new PVector(random(-_sceneSize.x,_sceneSize.x),random(-_sceneSize.y,_sceneSize.y));
    _isActive = true;
    
  }
  
  public void processState(boolean state){
    if(state){
      begin();
    }else{
      end();
    }
  }
  
  public void end(){
    _isActive = false;
  
  }
  
 
}  