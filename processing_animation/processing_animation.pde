MainAnimator _ma;
ColorPalette cp;
void setup() {
  fullScreen(P3D);
  frameRate(60);
  smooth(5);
  _ma= new MainAnimator(width, height);
}

void draw() {
  _ma.updateAndDisplay();
}

void keyPressed() {

  switch(key) {
  case 'r': 
  _ma.reset(); 
    break;
  }
}