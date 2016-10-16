static class AnimationEffects{
  public static final String ZOOM = "zoom";
  public static final String DUPPLICATE = "dupplicate";
  public static final String FEEDBACK = "feedback";
  
  public static final String [] LIST = {ZOOM,FEEDBACK};
  public static String getRandom(){
    Random r = new Random();
    return LIST[r.nextInt(LIST.length)];
  }
  
}