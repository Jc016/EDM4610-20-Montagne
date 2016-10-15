//Tnterface PostProcessEffect
// Patron de conception pour les effets visuels
// Par Jean-Christophe Leclerc-Massé
interface PostProcessEffect {
  public void  applyEffectOn(PGraphics context);
  public void  toggleActiveState();
}