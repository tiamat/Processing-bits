import point2line.*;  //library with some geometry methods.
import controlP5.*;    //GUI controls library

ControlP5 controlP5;
Textlabel circleTL;
Textlabel lineTL;
Textlabel couplingTL;
Textfield radiusTF;

String circleMsg;
String lineMsg;
String couplingMsg;

String couplingRadInput;

Circle circle;
Line ln;
Point P;
Coupling cpl;

Vect2 pCoord;
Vect2 mousePos;
public final int canvasHeight = 500;
public final int canvasWidth = 400;

void setup() {
  ellipseMode(RADIUS);
  
  circleMsg = "";
  lineMsg = "";
  couplingMsg = "";
  couplingRadInput = "";
  
  controlP5 = new ControlP5(this);
  
  radiusTF = controlP5.addTextfield("Coupling Radius",20,400,100,20);
  radiusTF.setText("50");
  circleTL = controlP5.addTextlabel("label","Circle:",20,440);
  lineTL = controlP5.addTextlabel("label1","Line:",20,460);
  couplingTL = controlP5.addTextlabel("label2","Coupling:",20,480);
  
  circle = new Circle();
  ln = new Line();
  P = new Point();
  mousePos = new Vect2();
  pCoord = new Vect2();
  cpl = new Coupling();
  
  size(canvasWidth,canvasHeight);
  background(255,255,255);
  smooth();
}

void draw() {
//  background(255,255,255);  //overwrites previous frame
  background(0);
    
  circle.draw();
  ln.draw();
  
  /*  --   depracted due to Coupling intersection point with line is calculated by default
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
  
  //taking user input
  couplingRadInput = radiusTF.getText();
  if (couplingRadInput != ""){
    try{
      cpl.radius = Float.valueOf(couplingRadInput.trim()).floatValue(); 
      cpl.radiusSpecified = true;
    } catch (NumberFormatException nfe){
      println("ERROR: radius shall be numerical");
    }
  }
  
  
  //draws coupling
  if ( circle.drawn && ln.drawn ){
    cpl.drawHelpers = true;
    cpl.draw(ln, circle, cpl.radius);    //
    couplingMsg = "Coupling: radius: " + cpl.radius + "Center" + cpl.center;
    couplingTL.setValue(couplingMsg);
  }
  
}

void mouseMoved(){
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

void mousePressed() {
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

void mouseDragged() {
  //circle is drawing
  if(mouseButton == LEFT) {
    //change she shape of circle if circle is not drawn yet
    if (!circle.drawn && !P.hovered){
      //draw the circle
      int relX = mouseX;
      int relY = mouseY;
      circle.radius = dist(circle.center.x, circle.center.y, relX, relY);
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

void mouseReleased() {
  if(mouseButton == LEFT) {
    circle.drawn = true;
    //P.dragging = false;
    circleMsg = "CIRCLE    Center: x: " + circle.center.x + "; y: " + circle.center.y + ";     Radius: " + circle.radius;
    circleTL.setValue(circleMsg);
  } 
  else if(mouseButton == RIGHT) {
    ln.drawn = true;
    lineMsg = "LINE      A (" + ln.P1.x + ", " + ln.P2.y + "), B (" + ln.P2.x + ", " + ln.P2.y + ")";
    lineTL.setValue(lineMsg);
  }
}



