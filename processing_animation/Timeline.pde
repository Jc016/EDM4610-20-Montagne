import java.util.*;
public static class Timeline extends TimerTask
{
  private final float MINUTE_DURATION = 60;
  private float _position =0;
  private int _bpm = 90;
  private int _oldBpm = 90;
  private int  _length = 60;
  private float _positionSpeed =  MINUTE_DURATION/ _bpm ;
  private MainAnimator _ma = null;
  private Timer _timer;
  
  private Timeline()
  {
    
  }

  private static Timeline _instance = null;

  public static  Timeline getInstance()
  {      
    if (_instance == null)
    {   
      _instance = new Timeline();
    }
    return _instance;
  }


  public void setMainAnimator(MainAnimator ma) {
    _ma = ma;
    _timer = new Timer();
  }
  
  public void begin(){
    _timer.scheduleAtFixedRate(this, (long)0, (long)_positionSpeed * 1000);
  }
  
  public void run(){
    _position += _positionSpeed;
  }
  
  public void setNewBpm(int bpm){
    _oldBpm = _bpm;
    _bpm = bpm;
  }
  
  private void scaletoNewSettings(){
    float scaleFactor = _bpm / _oldBpm;
    end();
    _positionSpeed =  MINUTE_DURATION/ _bpm ;
    _length *= scaleFactor;
    begin();
    
  }
  
  public void end(){
    _timer.cancel();
  }
  
  public void resetTimer(){
    end();
    _position = 0;
    begin();
   
  }
  
  
}