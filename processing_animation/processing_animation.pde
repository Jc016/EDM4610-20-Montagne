MainAnimator _ma;
ColorPalette cp;
void setup() {
  fullScreen(P3D,1);
  frameRate(60);
  _ma= new MainAnimator(width,height);
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