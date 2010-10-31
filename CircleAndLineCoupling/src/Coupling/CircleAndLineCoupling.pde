import point2line.*;  //library with some geometry methods.
	
Circle circle;
Line ln;
Point P;
Vect2 pCoord;
Vect2 mousePos;
Coupling cpl;

public void setup() {
  circle = new Circle();
  ln = new Line();
  P = new Point();
  mousePos = new Vect2();
  pCoord = new Vect2();
  cpl = new Coupling(this);
  size(400,400);
  background(255,255,255);
  smooth();
}

public void draw() {
  background(255,255,255);  //overwrites previous frame
    
  circle.draw();
  ln.draw();
  if (ln.drawn){
    P.drawMiddle(ln);
    P.draw();
  }
  /* 
  if (P.userSet && ln.drawn){
    //draws Point with userset precision
    P.draw();
  }else if (!P.userSet && ln.drawn ){
    //draws default Point in a closest point to the circle center
    pCoord = Geometry.closestLineEndToPoint(circle.center, ln.P1, ln.P2);
    P.draw(pCoord.x, pCoord.y);
  }*/
  
  //draws coupling
  if ( circle.drawn && ln.drawn ){
    cpl.draw(ln, circle, P);
  }
}

public void mouseMoved(){
  mousePos.x = mouseX;
  mousePos.y = mouseY;
  
  //mouse hovers circle
  if ( Geometry.pointInsideCircle(circle, mousePos)){
    circle.hovered = true;
  
  //mouse hovers point
  } else if (Geometry.pointOnPoint(P, mousePos)){
    P.hovered = true;
    
  //mouse hovers line
  } else if (Geometry.pointOnLine(ln, mousePos)){
    ln.hovered = true;
    
  //mouse hovers no object
  } else {
    circle.hovered = false;
    ln.hovered = false;
    //P.hovered = false;
  }
}

public void mousePressed() {
  if (mouseButton == LEFT) {
    
    if (!circle.drawn && !P.hovered){
      circle.center.x = mouseX;
      circle.center.y = mouseY;
    }
    /*if (P.hovered){
      P.userSet = true;
      P.dragging = true;
    }*/
  } 
  else if(mouseButton == RIGHT) {
    if(!ln.drawn){
      ln.P1.x = mouseX;
      ln.P1.y = mouseY;
      ln.P2.x = mouseX;
      ln.P2.y = mouseY;
    }
  }
}

public void mouseDragged() {
  //circle is drawing
  if(mouseButton == LEFT) {
    //change she shape of circle if circle is not drawn yet
    if (!circle.drawn && !P.hovered){
      //draw the circle
      int relX = mouseX;
      int relY = mouseY;
      circle.radius = dist(circle.center.x, circle.center.y, relX, relY)*2;
    } else if (circle.drawn && circle.hovered) {
      //move the circle
      circle.center.x = mouseX;
      circle.center.y = mouseY;
    } /*else if (P.dragging){
      int relX = mouseX;
      int relY = mouseY;
      P.move(ln, relX, relY);
    }*/
    
  } 
  //line is drawing
  else if(mouseButton == RIGHT) {
    if(!ln.drawn){
      //draw the line
      ln.P2.x = mouseX;
      ln.P2.y = mouseY;
    }else if (ln.drawn && ln.hovered) {
      //move the line
    }
  }
}

public void mouseReleased() {
  if(mouseButton == LEFT) {
    circle.drawn = true;
    //P.dragging = false;
  } 
  else if(mouseButton == RIGHT) {
    ln.drawn = true;
  }
}



