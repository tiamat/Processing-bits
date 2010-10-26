import point2line.*;  //library with some geometry methods.

Circle circle;
Line ln;
Point P;
Vect2 pCoord;
Vect2 mousePos;

void setup() {
  circle = new Circle();
  ln = new Line();
  
  P = new Point();
  
  mousePos = new Vect2();
  pCoord = new Vect2();
  size(400,400);
  background(255,255,255);
  smooth();
}

void draw() {
  background(255,255,255);  //overwrites previous frame
    
  circle.draw();
  ln.draw();
   
  if (P.userSet){
    //draws Point with userset precision
    P.draw();
  }else{
    //draws default Point in a closest point to the circle center
    pCoord = Geometry.closestLineEndToPoint(circle.center, ln.P1, ln.P2);
    P.draw(pCoord.x, pCoord.y);
  }
   
  
  //draws coupling
  if ( circle.drawn && ln.drawn ){

  }
}

void mouseMoved(){
  mousePos.x = mouseX;
  mousePos.y = mouseY;
  
  //mouse hovers circle
  if ( Geometry.pointInsideCircle(circle, mousePos)){
    circle.hovered = true;
  }else {
    //mouse hovers no object
    circle.hovered = false;
    ln.hovered = false;
    P.hovered = false;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    circle.center.x = mouseX;
    circle.center.y = mouseY;
  } 
  else if(mouseButton == RIGHT) {
    ln.P1.x = mouseX;
    ln.P1.y = mouseY;
    ln.P2.x = mouseX;
    ln.P2.y = mouseY;
  }
}

void mouseDragged() {
  if(mouseButton == LEFT) {
    int relX = mouseX;
    int relY = mouseY;
    circle.radius = dist(circle.center.x, circle.center.y, relX, relY)*2;
  } 
  else if(mouseButton == RIGHT) {
    ln.P2.x = mouseX;
    ln.P2.y = mouseY;
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {
    circle.drawn = true;
  } 
  else if(mouseButton == RIGHT) {
    ln.drawn = true;
  }
}



