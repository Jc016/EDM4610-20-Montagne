
// ======================================  « MASQUES »  ========================================== 
// =========================================== PAR =============================================== 
// =================================  XAVIER MARTEL-LACHANCE  ====================================

//        ================================================================================
//        =============================== INSTRUCTIONS ===================================
//        ================================================================================
//        ===------------ (1) Lorsque vous appuyez sur la touche «ESPACE»,  -----------===
//        ===------------- les traits changent de formes et de direction  -------------===
//        ===----------------- (N'hésitez pas à marteler la touche!) ------------------===
//        ===--- (2) Lorsque vous appuyez sur la touche «C», les tons s'inversent!  ---===
//        ===------------------ (3) Lorsque vous faites du bruit, ---------------------===
//        ===-------------- les traits changent de formes et de direction -------------===
//        ================================================================================
//        ================================================================================

//        ================================================================================
//        ======================== À noter qu'il s'agit également ========================
//        ================= d'une recherche pour le travail de métronome =================
//        ======= où l'objectif était de créer un masque avec plusieurs instances ========
//        ================================================================================
class Esprit {

  //==================================================================================
  //================================= SETUP ==========================================
  //==================================================================================
  PGraphics _pg;
  Esprit() {
    _pg= createGraphics(width, height, P2D);
    /////////////////// Appel des agents ////////////////////////
    for (int i=0; i<agents.length; i++) {                      //  
      agents[i] = new Agent();                                 //
    }////////////////////////////////////////////////////////////

    // Image réalisé par Gabrielle Martineau, Étudiante du Baccalauréat en communication (médias interactifs)
    _pg.imageMode(CENTER); // La photo sera centrée
    photo = loadImage("spirit/esprit1.tga");
    copiePhoto = loadImage("spirit/esprit1.tga"); // On va cherche la photo voulue

    alphaArray = new int[photo.width*photo.height];
  }  

  //==================================================================================
  //=========================== INITIATION DU MASQUE =================================
  //==================================================================================
  void initMasque() { // On assigne la copie de la photo au PGraphic
    pg = createGraphics(copiePhoto.width, copiePhoto.height, JAVA2D);
  }

  //==================================================================================
  //=================================== DRAW =========================================
  //==================================================================================
  void update() {
    //background(couleur, overlayAlpha); // Couleur du par dessus l'image


    if (copiePhoto.width>1) { // Si la copie de la photo est plus grande que 1
      if (!chargement) { // Si la variable « chargement » est fausse
        initMasque(); // On appel la fonction d'initiation du masque
        chargement=true; // On met la variable « chargement » a vraie
      }
      updatePg(); // On appel la fonction de mise à jour du PGraphics
      for (int j = 0; j < photo.height; j++) {
        for (int i = 0; i < photo.width; i++) {
          int alphaTga = int((copiePhoto.pixels[(j*copiePhoto.width)+i] >> 24) & 0xFF);
          int alphaPg = int(pg.pixels[(j*photo.width)+i] & 0xFF);
          int alphaTotal = alphaTga&alphaPg;
          alphaArray[(j*photo.width)+i] = color(alphaTotal);
        }
      }

      photo.mask(alphaArray);
      //image(img, width/2, height/2);

      //PImage img = copiePhoto.get(); // On associe la photo à sa copie
      //img.mask(pg); // On applique un masque du Pgraphics sur la photo 
      _pg.beginDraw();
      _pg.clear();
      _pg.image(photo, width/2, height/2); // On appel la photo et on la place
      _pg.endDraw();
    }



    strokeWidth = 1.5 + pulsionG; // La grosseur des traits est additionnée de la variable pulsionG
    if (pulsionG >= 0) { // Si la variable pulsionG est plus grand ou égale à zéro
      pulsionG -= 0.1; // On la fait diminué de 0.1 à chaque «frame»
    }

    noiseStrength = 10 + pulsionF; // La direction du noise des traits est additionnée de la variable pulsionF
    if (pulsionF >= 0) { // Si la variable pulsionF est plus grand ou égale à zéro
      pulsionF -= 9; // On la fait diminué de 9 à chaque «frame»
    }
  }
  PGraphics getContext() {
    return _pg;
  } 
  //==================================================================================
  //============================ UPDATE DU PGRAPHICS =================================
  //==================================================================================
  void updatePg() {
    pg.beginDraw(); // ON COMMENCE À DESSINER LE PGRAPHICS ----------------->

    pg.clear(); // On purifie le PGrapics
    pg.stroke(0, 255); // Les traits dans le stroke seront noir --> Voir l'utilité

    /////////// On dessine les agents (les traits) /////////////
    if (drawMode == 1) { // On assigne le PGraphics à update1 // 
      for (int i=0; i<agentsCount; i++) agents[i].update1(pg);//
    } else {             // On assigne le PGraphics à update2 //
      for (int i=0; i<agentsCount; i++) agents[i].update2(pg);//
    }///////////////////////////////////////////////////////////

    pg.endDraw(); // ON FINIT DE DESSINER LE PGRAPHICS --------------------->
  }

  void receiveTick() {
    if (pulsionG < 1) { // Si la variable pulsionG est plus petite que 1     //
      pulsionG += 0.2; // On l'additionne de 1                                 //
    }                                                                        //  
    if (pulsionF < 100) { // Si la variable pulsionF est plus petite que 100 //
      pulsionF += 100; // On l'additionne de 100                             //
    }                                                                        //
    noiseScale = random(300, 1000); // On position le
  }

  //==================================================================================
  //============================== TOUCHE ENFONCÉE ===================================
  //==================================================================================
  void keyReleased() {
    // La touche « ENTER » remplace ici le tempo qui sera éventuellement capté 
    //                     lors du TP avec le métronome
    if (key == ENTER) { /////// Lorsque l'on enfonce la touche « ENTER » ////////

      //incrementationG += 1;
      //println(incrementationG);

      //if (incrementationG >= 10 && incrementationG < 20) {
      //  copiePhoto = requestImage("esprit2.tga");
      //} 
      //if (incrementationG >= 20 && incrementationG < 30) {
      //  copiePhoto = requestImage("esprit3.tga");
      //}
      //if (incrementationG >= 30) {
      //  copiePhoto = requestImage("esprit1.tga");
      //  incrementationG -= 30;
      //}
    } ///////////////////////////////////////////////////////////////////////////                  

    if (key == 'c' || key== 'C') { // Lorsque l'on enfonce la touche « C » //
      if (couleur == 0) { // Si la couleur est égale à zéro                // 
        couleur += 255; // On l'additionne de 255                          //
      } else {          // Sinon                                           //  
        couleur -= 255; // On la soustrait de 255                          //
      } /////////////////////////////////////////////////////////////////////
    }

    if (key == 'a' || key== 'A') {
      copiePhoto = requestImage("esprit1.tga");
      photo = requestImage("esprit1.tga");
    }

    if (key == 'b' || key== 'B') {
      copiePhoto = requestImage("esprit2.tga");
      photo = requestImage("esprit2.tga");
    }

    if (key == 'c' || key== 'C') {
      copiePhoto = requestImage("esprit3.tga");
      photo = requestImage("esprit3.tga");
    }
  }
}