import java.io.*;

class ColorPalette {
  PImage _bufferImage;
  color[] _colors;
  IntList _colorsToBeUsed;
  ColorPalette() {
    fetchFromFolder();
    reset_colorsToBeUsed();
  }

  private void fetchFromFolder() {
    File folder = new File(dataPath("color_palettes"));
    ArrayList<String> filteredFileNames = new ArrayList<String>();
    String fileName = "";
    if (folder != null){
      for(File file: folder.listFiles()){
        if(file.getName().endsWith(".jpg")){
          filteredFileNames.add(file.getName());
        }
      }
      int fileNum =(int)random(0, filteredFileNames.size());
      fileName = dataPath("color_palettes")+"/"+filteredFileNames.get(fileNum);
      _bufferImage = loadImage(fileName);
      _bufferImage.loadPixels();
      _colors = new color[_bufferImage.pixels.length];
      arrayCopy(_bufferImage.pixels, _colors);
    }
  }
  
  private void reset_colorsToBeUsed(){
    _colorsToBeUsed = new IntList();
    for(int i = 0; i < _colors.length; i++){
      _colorsToBeUsed.set(i,i);
    }
  }
  
  private color fetchRandomColor(){
      int index = (int)random(0,_colorsToBeUsed.size());
      color ret = _colorsToBeUsed.size() > 0 ? _colors[_colorsToBeUsed.get(index)]: -1;
      if(ret != -1){
        _colorsToBeUsed.remove(index);
      }
      return ret;
  }

  public void debugToScreen() {
    if (_colors != null) {
      int rectWidth = width/ _colors.length;
      background(0);
      noStroke();

      for (int i = 0; i < _colors.length; i ++) {
        int x =i*rectWidth;
        fill(_colors[i]);
        rect(x, 0, x+rectWidth, height);
      }
    }
  }
}