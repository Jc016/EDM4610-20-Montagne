//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class ChromaticAberrationEffect extends PostProcessEffect {
  private final float COLOR_PIXELS_OFFSET = 30;
  private final float ABBERRATION_CHANNELS_OPACITY = 30 ;
  private final float ABBERRATION_CHANNELS_SPEED = 0;
  private final color OVERLAY_COLOR = color(20);

  public void applyEffectOn(PGraphics context) {
    if (_isActive) {
      PGraphics redChannel =  getChannelColorContext(context, ColorBitOffsets.RED);
      PGraphics greenChannel =getChannelColorContext(context, ColorBitOffsets.GREEN);
      PGraphics blueChannel = getChannelColorContext(context, ColorBitOffsets.BLUE);

      context.beginDraw();
      context.pushStyle();
      context.tint(255, ABBERRATION_CHANNELS_OPACITY);
      showChannel(context, redChannel, -COLOR_PIXELS_OFFSET, 0);
      showChannel(context, greenChannel, COLOR_PIXELS_OFFSET, 0);
      showChannel(context, blueChannel, 0, -COLOR_PIXELS_OFFSET);
      context.popStyle();

      context.endDraw();
    }
  }

  private PGraphics getChannelColorContext(PGraphics context, int channel) {
    PGraphics bufferContext = createGraphics(context.width, context.height);
    bufferContext.beginDraw();
    bufferContext.background(0);
    bufferContext.endDraw();

    bufferContext.loadPixels();
    for (int i = 0; i < bufferContext.pixels.length; i ++) {
      bufferContext.pixels[i] = retrieveChannelColorValue(context.pixels[i], channel) ;
    }
    bufferContext.updatePixels();
    return bufferContext;
  }

  private color retrieveChannelColorValue(color c, int channel) {
    return ((c >> channel) | 0xff) << channel;
  }

  private PGraphics copyContext (PGraphics context) {
    PGraphics copyContext = createGraphics(context.width, context.height);
    copyContext.beginDraw();
    copyContext.background(0);
    copyContext.endDraw();
    copyContext.loadPixels();
    context.loadPixels();
    for (int i = 0; i < context.pixels.length; i ++) {
      copyContext.pixels[i] = context.pixels[i];
    }
    copyContext.updatePixels();
    return  copyContext;
  }

  private void showContext(PGraphics drawContext, PGraphics context) {
    drawContext.image(context, 0, 0);
  }

  private void showChannel(PGraphics drawContext, PGraphics channel, float xOffset, float yOffset) {
    final float OFFSET_ABBERRATION = frameCount *ABBERRATION_CHANNELS_SPEED;
    float x = map((float)cos(OFFSET_ABBERRATION), -1, 1, -xOffset, xOffset);
    float y = map((float)sin(OFFSET_ABBERRATION), -1, 1, -yOffset, yOffset);
    drawContext.pushMatrix();
    drawContext.translate(x, y);
    showContext(drawContext, channel);
    drawContext.popMatrix();
  }
  private void drawOverlay(PGraphics drawContext) {
    drawContext.pushStyle();
    drawContext.pushMatrix();
    drawContext.stroke(OVERLAY_COLOR);
    drawContext.strokeWeight(COLOR_PIXELS_OFFSET*2);
    drawContext.noFill();
    drawContext.rect(0, 0, drawContext.width, drawContext.height);
    drawContext.popMatrix();
    drawContext.popStyle();
  }

  public void begin() {
  }
  public void processState(boolean state) {
  }
  public void end() {
  }
}  