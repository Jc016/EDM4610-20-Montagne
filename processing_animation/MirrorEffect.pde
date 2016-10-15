//Classe ChromaticAberrationEffect
// Applique un effet d'aberration chromatique sur un PGraphics
//Par Jean-Christophe Leclerc-Massé

class MirrorEffect extends PostProcessEffect {

  public void applyEffectOn(PGraphics context) {
    float w = context.width, h = context.height;
    context.beginDraw();
    context.clear();
    context.noStroke();
    context.noFill();
    context.pushMatrix();
    context.pushStyle();
    context.scale(-1,-1);
    context.image(context,-w,-h);
    context.popStyle();
    context.popMatrix();
    context.image(context,0,0);
    context.endDraw();
  }
  

  
  
 
}  