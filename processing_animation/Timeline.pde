import java.util.*;
import java.math.*;
public  class Timeline
{
  public final int MINUTE_DURATION = 60000;
  public static final int DEFAULT_SYSTEM_BPM = 60;
  private float _position =0;
  private int _bpm = DEFAULT_SYSTEM_BPM;
  private int  _length = 30;
  private int _startInterval = 0;
  private int _intervalLenght = 0;
  private MainAnimator _ma;

  private Timeline(MainAnimator ma)
  {
    _ma = ma;
    init();
  }

  public void begin() {
   
    _startInterval = millis();
    _intervalLenght = MINUTE_DURATION / _bpm;
    _position = 0;
    println("beginAt: " + _intervalLenght );
    
  }

  public void setNewBpm(int bpm) {
    _bpm = bpm;
    println("setting: " + _bpm );
    begin();
  }
  public int getBpm() {
    return _bpm;
  }

  public int getLength() {
    return _length;
  }

  public float getPosition() {
    return _position;
  }

  public void reset() {
    init();
  }
  
  public void processTimer(){
    if(millis() - _startInterval >= _intervalLenght){
      _position ++;
      _startInterval = millis();
      _ma.processTick();
      
    }
  }

  private void init() {
    _position = 0;
    _bpm = 60;
    _startInterval = millis();
    _intervalLenght = MINUTE_DURATION / _bpm;
  }
}