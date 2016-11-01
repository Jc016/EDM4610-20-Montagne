import netP5.*;
import oscP5.*;
OscP5 monOSC;
MainAnimator _ma;
ColorPalette cp;
int tempo;

////////////
  PImage photo, copiePhoto, ciel; // Déclaration de la photo ainsi que de sa copie
  PGraphics pg; // Déclaration de la variable pour le PGraphics
  boolean chargement = false; // Déclaration de la variable de chargement de la copie de la photo
  float pulsionG = 0, pulsionF = 0; // Déclaration des variables qui font changer la taille et la direction des traits
  float incrementationG = 0; // Déclaration de l'incrémentation globale (Sert à calculer le nombre de pulsion reçu)
  color couleur = 255; // Déclaration de la variables qui inverse les noirs et blancs

  int [] alphaArray;
  PImage copyArray;


  ///// Déclaration des variables de la classe «Agent» ///////
  ///////// ATTENTION PROVIENT DE DESIGN GENERATIF ///////////
  //////////////// NON RÉALISÉ PAR L'ÉlÈVE ///////////////////
  Agent[] agents = new Agent[10000];                        //
  int agentsCount = 2500;                                   // 
  float noiseScale = 300, noiseStrength;                    //
  float overlayAlpha = 0, agentsAlpha = 90, strokeWidth;    //
  int drawMode = 1;                                         // 
  ////////////////////////////////////////////////////////////
////////////
void setup() {
  fullScreen(P3D, 1);
  frameRate(24);
  _ma= new MainAnimator(width, height);
  monOSC = new OscP5(this, 54000);
  tempo = ;
}

void draw() {
  _ma.setBpm(tempo);
  _ma.updateAndDisplay();
}

void keyPressed() {

  switch(key) {
  case 'r': 
    _ma.reset();
    break;
  case 'm':  

    break;
  }
}


void oscEvent(OscMessage leOscMessage) {
  if (leOscMessage.addrPattern().equals("/r")) {
    tempo = (int)leOscMessage.get(0).floatValue();
    //_ma.setBpm((int)tempo);
  }
}