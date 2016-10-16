//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class ZoomEffect extends PostProcessEffect implements ITimelineAnimation {
  final float MIN_SCALE = 1.5;
  final float MAX_SCALE = 2.3;
  float _scaleFactor = 1.0;
  final float TRANSLATE_PRECISIOM = 0.1;
  PVector _translate;
  PVector _sceneSize;
  int _startTranslateX = (int)random(0, 10000);
  int _startTranslateY = (int)random(0, 10000);

  ZoomEffect(PGraphics c) {
    super();
    _isActive =false;
    _sceneSize = new PVector(c.width, c.height);
  }

  public void applyEffectOn(PGraphics context) {
    if (_isActive) {
      int bpm = Timeline.getInstance().getBpm();
      float speed = (float)bpm/ (float)Timeline.DEFAULT_SYSTEM_BPM*30;
      PImage bufferImage = context.get();
      context.beginDraw();
      context.clear();
      context.noStroke();
      context.noFill();
      context.translate(_sceneSize.x*0.5, _sceneSize.y*0.5);
      context.scale(_scaleFactor);
      context.translate(_translate.x, _translate.y);
      context.imageMode(CENTER);
      context.image(bufferImage, 0, 0);
      context.endDraw();  

      _translate.x  +=noise(_startTranslateX+frameCount * TRANSLATE_PRECISIOM-0.5) * speed;
      _translate.y +=noise(_startTranslateY+frameCount * TRANSLATE_PRECISIOM-0.5) * speed;
    }
  }


  public void begin() {
    _scaleFactor = random(MIN_SCALE, MAX_SCALE);
    _translate =new PVector(random(-_sceneSize.x/4, _sceneSize.x/4)/_scaleFactor, random(-_sceneSize.y/4, _sceneSize.y/4)/_scaleFactor);
    _translate.div(_scaleFactor);
    _isActive = true;
  }

  public void processState(boolean state) {

    if (state) {
      begin();
    } else {
      end();
    }
  }

  public void end() {
    _isActive = false;
  }
}  