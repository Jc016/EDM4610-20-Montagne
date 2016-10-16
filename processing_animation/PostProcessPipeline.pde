//Classe PostProcessPipeline
// Gère des constantes relative au type d'objet physique
//Par Jean-Christophe Leclerc-Massé
class PostProcessPipeline {
  HashMap<String, PostProcessEffect> m_postProcessEffects;
  PostProcessPipeline() {
    init();
  }

  private void init() {
    m_postProcessEffects = new HashMap<String, PostProcessEffect>();
  }

  public void addEffectToPipeline(String name, PostProcessEffect ppe) {
    m_postProcessEffects.put(name, ppe);
  }

  public void removeEffectFromPipeline(String name) {
    m_postProcessEffects.remove(name);
  }
  
  public PostProcessEffect getEffect(String effectKey){
    return m_postProcessEffects.get(effectKey);
  }
  
  public void setPipelineTo(PGraphics context) {
    for (PostProcessEffect ppe : m_postProcessEffects.values()) {
      ppe.applyEffectOn(context);
    }
  }
  
  public void toggleEffect(String name){
    m_postProcessEffects.get(name).toggleActiveState();
  }
}