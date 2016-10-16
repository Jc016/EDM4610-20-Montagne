import java.util.*;
import java.math.*;
public static  class Timeline
{
  private final float MINUTE_DURATION = 60;
  public static final int DEFAULT_SYSTEM_BPM = 60;
  private float _position =0;
  private int _bpm = DEFAULT_SYSTEM_BPM;
  private int _oldBpm = DEFAULT_SYSTEM_BPM;
  private int  _length = 180;
  private float _positionSpeed =  MINUTE_DURATION/ _bpm ;
  private MainAnimator _ma = null;
  private Timer _timer;
  private TimerTask _timerTask;
  private HashMap<Integer, AnimationAction> _listActions ;
  private Random _r;
  private boolean _isPlaying;

  private Timeline()
  {
    init();
  }

  private  static  Timeline _instance  ;

  public static Timeline getInstance()
  {      
    if (_instance == null)
    {   
      _instance = new Timeline();
    }
    return _instance;
  }

  public void addAction(int startTime, AnimationAction action) {
    _listActions.put(startTime, action);
  }


  public void setMainAnimator(MainAnimator ma) {
    _ma = ma;
  }

  public void begin() {
    if (!_isPlaying) {
      _isPlaying = true;
      _timer = new Timer();
      _timerTask =  new TimerTask() {  
        @Override
          public void run() {
          _position += _positionSpeed;
          println(_position);
          if (_listActions.containsKey((int)_position)) {
            AnimationAction aa =  _listActions.get((int)_position);
            _ma.processAction(aa);
            println(aa.toString());
            _listActions.remove(aa);
          }
        }
      };
      _timer.scheduleAtFixedRate(_timerTask, (long)0, (long)(MINUTE_DURATION/_bpm * 1000));
    }
  }

  public void setNewBpm(int bpm) {
    end();
    _oldBpm = _bpm;
    _bpm = bpm;
    scaleToNewSettings();
    begin();
  }
  public int getBpm() {
    return _bpm;
  }

  public int getLength() {
    return _length;
  }
  
  public float getPosition(){
    return _position;
  }

  private void scaleToNewSettings() {
    //float scaleFactor = (float)_bpm / (float) _oldBpm;
    end();
    _positionSpeed =  1 ;
    // _length *= scaleFactor;
    begin();
  }

  public void end() {
    if (_isPlaying) {
      _timer.purge();
      _timer.cancel();
      _isPlaying = false;
    }
  }

  public void reset() {
    end();
    _instance = new Timeline();
    init();
    begin();
  }

  private void init() {
    _listActions = new HashMap<Integer, AnimationAction>();
    _position = 0;
    _bpm = 60;
    _oldBpm = _bpm;
    _length = 60;
    _r = new Random();
    _isPlaying = false;
  }
}