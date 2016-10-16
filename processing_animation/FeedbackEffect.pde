//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class FeedbackEffect extends PostProcessEffect implements ITimelineAnimation {

  FeedbackEffect(PGraphics c) {
    super();
    _isActive =false;
  }

  public void applyEffectOn(PGraphics context) {
    if (_isActive) {
      int bpm = Timeline.getInstance().getBpm();
      float speed = (float)bpm/ (float)Timeline.DEFAULT_SYSTEM_BPM*20;
      context.beginDraw();
      context.endDraw();
    }
  }


  public void begin() {
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