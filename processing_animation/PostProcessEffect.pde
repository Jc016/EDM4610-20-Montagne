//Tnterface PostProcessEffect
// Patron de conception pour les effets visuels
// Par Jean-Christophe Leclerc-Massé
abstract class PostProcessEffect {
  protected boolean _isActive =true;
  protected int timelinePosition = 0;
  public abstract void  applyEffectOn(PGraphics context);
  public void resetTimeline() {
    timelinePosition++;
  }
  public void toggleActiveState() {
    _isActive = !_isActive;
  }
}