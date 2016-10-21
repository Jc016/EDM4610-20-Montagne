//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class FeedbackEffect extends PostProcessEffect implements ITimelineAnimation {
  private final int NUMBER_PASS = 25;
  PGraphics _pg;
  boolean _hasDrawOriginal;
  int _w, _h;
  FeedbackEffect(PGraphics c) {
    super();
    _w = c.width;
    _h = c.height;
    _isActive =false;
    _hasDrawOriginal = false;
  }

  public void applyEffectOn(PGraphics context) {
    if (_isActive) {
    }
  }


  public void begin() {
    _isActive = true;
    _hasDrawOriginal = false;
  }


  public void processState(boolean state) {

    if (state) {
      begin();
    } else {
      end();
    }
  }

  private void applyFeedback() {
    //Taken from Generative Design book page 294
    int x1 =(int)random(0, _pg.width);
    int y1 =0;
    int x2 = round(x1+random(-7, 7));
    int y2 = round(random(-5, 5));

    int w = (int)random(35, 50);
    int h = _pg.height;
    _pg.beginDraw();
    _pg.copy(x1, y1, w, h, x2, y2, w, h);
    _pg.endDraw();
  }

  public void end() {
    _isActive = false;
  }
}  