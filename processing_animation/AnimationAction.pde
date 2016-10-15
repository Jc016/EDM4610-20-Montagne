public class AnimationAction{
  private String _target, _effect;
  private boolean _state;
  AnimationAction(String target, String effect, boolean state) {
    _target = target;
    _effect = effect;
    _state = state;
  }
  
  public String getTarget(){
    return _target;
  }
  
  public String getEffect(){
    return _effect;
  }
  
  public boolean getState(){
    return _state;
  }
  
  public String toString(){
    return "Target: "+_target+" Effect: "+_effect+" State: "+ _state;
  }
}