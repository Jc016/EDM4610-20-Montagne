
//     CLASSE « AGENT » ENTIÈREMENT PRISE DANS LE LIVRE « DESIGN GÉNÉRATIF »
//    Quelques légères modification de la part de l'élève (Voir commentaires)

class Agent {
  PVector p, pOld;
  float stepSize, angle;
  boolean isOutside = false;

  Agent() {
    p = new PVector(random(width), random(height));
    pOld = new PVector(p.x, p.y);
    stepSize = random(1, 5);
  }

  void update1(PGraphics pg) {
    angle = noise(p.x/noiseScale, p.y/noiseScale) * noiseStrength;
    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;

    //if (p.x<-10) isOutside = true;
    //else if (p.x>width+10) isOutside = true;
    //else if (p.y<-10) isOutside = true;
    //else if (p.y>height+10) isOutside = true;

    // Les valeurs de X et Y ont été changé afin de se restreindre aux dimension de la photo
    if (p.x<0) isOutside = true;
    else if (p.x>525) isOutside = true;
    else if (p.y<0) isOutside = true;
    else if (p.y>695) isOutside = true;

    if (isOutside) {
      p.x = random(width);
      p.y = random(height);
      pOld.set(p);
    }
    pg.stroke(255); // On associe le PGraphics au trait
    pg.strokeWeight(strokeWidth*stepSize); // On associe le PGraphics à la taille du trait
    pg.line(pOld.x, pOld.y, p.x, p.y); // On associe le PGraphics à la ligne

    pOld.set(p);

    isOutside = false;
  }

  void update2(PGraphics pg) {

    angle = noise(p.x/noiseScale, p.y/noiseScale) * 24;
    angle = (angle - int(angle)) * noiseStrength;

    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;

    //if(p.x<-10) isOutside = true;
    //else if(p.x>width+10) isOutside = true;
    //else if(p.y<-10) isOutside = true;
    //else if(p.y>height+10) isOutside = true;

    // Les valeurs de X et Y ont été changé afin de se restreindre aux dimension de la photo
    if (p.x<0) isOutside = true;
    else if (p.x>525) isOutside = true;
    else if (p.y<0) isOutside = true;
    else if (p.y>695) isOutside = true;

    if (isOutside) {
      p.x = random(width);
      p.y = random(height);
      pOld.set(p);
    }
    pg.stroke(255); // On associe le PGraphics au trait
    pg.strokeWeight(strokeWidth*stepSize); // On associe le PGraphics à la taille du trait
    pg.line(pOld.x, pOld.y, p.x, p.y); // On associe le PGraphics à la ligne

    pOld.set(p);

    isOutside = false;
  }
}