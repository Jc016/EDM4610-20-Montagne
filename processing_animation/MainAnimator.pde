class MainAnimator {


  //Class global variables
  private final float MIN_ACTION_DURATION = 3;
  private final float MAX_ACTION_DURATION = 15;
  private final int MIN_OCCURENCES_ANIMATIONS = 20;
  private final int MAX_OCCURENCES_ANIMATIONS = 30;
  private final int START_TIME_EFFECT = 6;

  PGraphics _pg;
  Panorama _panorama;
  int _w, _h;
  Timeline _timeline;



  MainAnimator(int w, int h) {
    _w =w;
    _h =h;
    reset();
  }

  public void  triggerMainTick() {
  }

  public void reset() {
    background(0);
    _pg = createGraphics(_w, _h);
    _panorama = new Panorama(_w, _h);
    if (_timeline == null) {
      _timeline = Timeline.getInstance();
      _timeline.setMainAnimator(this);
    } else {
      _timeline.reset();
    }
    generateEffects();
    _timeline.setNewBpm(180);
  }


  public void update() {
    if (_timeline.getPosition() > _timeline.getLength()) {
      reset();
    }
  }

  public void processAction(AnimationAction animationAction) {
    _panorama.processAction(animationAction);
  }

  public void generateEffects() {
    int count = (int)random(MIN_OCCURENCES_ANIMATIONS, MAX_OCCURENCES_ANIMATIONS);
    ArrayList<Integer> startPositionsList = new ArrayList<Integer>();
    int nextStartPosition = -1;
    for (int i = 0; i < count; i++) {
      String effectTarget = AnimationTargets.getRandom();
      String  effect =  AnimationEffects.getRandom();
      do {
        nextStartPosition = (int)random(START_TIME_EFFECT, _timeline.getLength());
      } while (startPositionsList.indexOf(nextStartPosition) != -1);
      startPositionsList.add(nextStartPosition);

      initAnimationActions(nextStartPosition, effectTarget, effect);
    }
  }


  public void display() {
    _pg.beginDraw();
    _pg.background(255);
    _pg.noStroke();
    _pg.tint(255, 90);
    _panorama.render();
    _panorama.display(_pg);
    _pg.endDraw();
    image(_pg, 0, 0);
  }

  private void initAnimationActions(int start, String target, String effect) {
    _timeline.addAction(start, new AnimationAction(target, effect, true));
    _timeline.addAction(start + (int)random(MIN_ACTION_DURATION, MAX_ACTION_DURATION), new AnimationAction(target, effect, false));
  }

  public void updateAndDisplay() {
    update();
    display();
  }
}