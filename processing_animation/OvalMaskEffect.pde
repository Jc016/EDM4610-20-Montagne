

class OvalMaskEffect extends PostProcessEffect {
  PGraphics _bufferMask;
  OvalMaskEffect(PGraphics context) {
    int w = context.width, h = context.height;
    _bufferMask = createGraphics(w, h, P3D);
    _bufferMask.beginDraw();
    _bufferMask.noStroke();
    _bufferMask.background(0);
    _bufferMask.fill(255);
    _bufferMask.ellipse(w/2, h/2, w, h);
    _bufferMask.endDraw();
  }
  public void applyEffectOn(PGraphics context) {


    PImage bufferImage = context.get();
    context.beginDraw();
    context.clear();
    context.background(255);
    context.noStroke();
    bufferImage.mask(_bufferMask);
    context.image(bufferImage, 0, 0);
    context.endDraw();
  }

  public void begin() {
  }
  public void processState(boolean state) {
  }
  public void end() {
  }
}  