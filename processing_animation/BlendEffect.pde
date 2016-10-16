//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class BlendEffect extends PostProcessEffect {

  public void applyEffectOn(PGraphics context) {
    /*PGraphics mask = createGraphics(context.width,context.height);
    PImage bufferImage = context.get();
    mask.beginDraw();
    mask.background(230);
    mask.endDraw();
    float w = context.width, h = context.height;
    context.beginDraw();
    context.clear();
    bufferImage.mask(mask);
    context.image(bufferImage,0,0);
    context.endDraw();*/
  }
  
  public void begin(){}
  public void processState(boolean state){}
  public void end(){}
  

  
  
 
}  