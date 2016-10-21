static class AnimationTargets{
  //Letters are put before names to set layer order
  public static final String PANORAMA = "panorama";
  public static final String SUN = "bsun";
  public static  final String MOUNTAINS = "amoutains";
  public static  final String SKY="csky";
  
  public static final String [] LIST = {SUN,MOUNTAINS}; 
  
  public static String getRandom(){
    Random r = new Random();
    String chosen = LIST[r.nextInt(LIST.length)];
    println(chosen);
    return  chosen;
  }
  
}