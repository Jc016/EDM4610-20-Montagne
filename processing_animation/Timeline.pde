import java.util.*;
import java.math.*;
public static  class Timeline extends TimerTask
{
  private final float MINUTE_DURATION = 60;
  private float _position =0;
  private int _bpm = 60;
  private int _oldBpm = 60;
  private int  _length = 60;
  private float _positionSpeed =  MINUTE_DURATION/ _bpm ;
  private MainAnimator _ma = null;
  private Timer _timer;
  private HashMap<Integer, AnimationAction> _listActions ;
  private Random _r;
  private _isPlaying;

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
    _timer = new Timer();
  }

  public void begin() {
    _isPlaying = true;
    _timer.scheduleAtFixedRate(this, (long)0, (long)(_positionSpeed * 1000));
  }

  public void run() {
    _position += _positionSpeed;
    if (_listActions.containsKey((int)_position)) {
      AnimationAction aa =  _listActions.get((int)_position);
      _ma.processAction(aa);
      println(aa.toString());
    }
    println(_position);
  }

  public void setNewBpm(int bpm) {
    end();
    _oldBpm = _bpm;
    _bpm = bpm;
    scaleToNewSettings();
    begin();
  }

  private void scaleToNewSettings() {
    float scaleFactor = (float)_bpm / (float)_oldBpm;
    end();
    _positionSpeed =  MINUTE_DURATION/ _bpm ;
    println(_positionSpeed *1000);
    _length *= scaleFactor;
    begin();
  }

  public void end() {
    if (_isPlaying) {
      _timer.cancel();
      _isPlaying = false;
    }
  }

  public void reset() {
    end();
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