import point2line.*;  //library with some geometry methods.
import controlP5.*;    //GUI controls library

ControlP5 controlP5;
Textlabel circleTL;
Textlabel lineTL;
Textlabel couplingTL;
Textfield radiusTF;
Textlabel instructionsTL1, instructionsTL2, instructionsTL3;

String circleMsg;
String lineMsg;
String couplingMsg;

String couplingRadInput;

Circle circle;    
Line ln;
Point P;
Coupling cpl;

Vect2 pCoord;
Vect2 mousePos;      //shows current position of mouse cursor
Vect2 mousePress;    //shows coordinates of mouse when it was pressed
//Vect2 mouseChanged;  //shows shift of mouse

public final int canvasHeight = 500;
public final int canvasWidth = 400;

void setup() {
  size(400,500);
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
  
  instructionsTL1 = controlP5.addTextlabel("label3", "To draw a circle, press Left mouse button and drag the mouse", 20, 5);
  instructionsTL2 = controlP5.addTextlabel("label4", "To draw a line, press right mouse button and drag the mouse",20, 15 );
  instructionsTL3 = controlP5.addTextlabel("label5", "To move circle or line along the canvas, drag them",20, 25 );
  
  circle = new Circle();
  ln = new Line();
  P = new Point();
  mousePos = new Vect2();
  pCoord = new Vect2();
  mousePress = new Vect2();
  cpl = new Coupling();
  
  
  background(255,255,255);
  smooth();
}

void draw() {
  background(0);//overwrites previous frame
    
  circle.draw();
  ln.draw();
    
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
    if (cpl.radius > 0) {
      cpl.draw(ln, circle, cpl.radius);    //
      if(cpl.exists){
      couplingMsg = "COUPLING: radius: " + cpl.radius + "  Center (x: " + cpl.center.x + 
                 " y: " + cpl.center.y + ")";
      } else {
        couplingMsg = "!!Coupling with radius " + cpl.radius + " does not exist. Change radius";
      }
    } else {
      couplingMsg = "!!Coupling radius can not be negative";
    }
    couplingTL.setValue(couplingMsg);
  }
}


void mouseMoved(){
  mousePos.x = mouseX;
  mousePos.y = mouseY;  
  if (Geometry.pointOnEndOfLineSegment(ln,mousePos)){
    cursor(MOVE);
    return;
  }
  if (Geometry.pointOnLine(ln, mousePos)){
    /*mouse hovers a line*/
    ln.hovered = true;
    cursor(HAND);
    return;
  } else {
    ln.hovered = false;
    //cursor(ARROW);
    if(!ln.drawn || !circle.drawn){
      cursor(CROSS);
    }else{ 
      cursor(ARROW);
    }
  }
  
  //mouse hovers a circle
  if ( Geometry.pointInsideCircle(circle, mousePos)){
    circle.hovered = true;
    cursor(HAND);
    return;
  } else if (Geometry.pointOnCircleBorder(circle, mousePos)){
    /* mouse hovers the border of a circle */
    circle.hovered = true;
    cursor(MOVE);
    return;
  } else {
    circle.hovered = false;
    //cursor(ARROW);
    if(!ln.drawn || !circle.drawn){
      cursor(CROSS);
    }else{ 
      cursor(ARROW);
    }
  }    
}



void mousePressed() {
  if (mouseButton == LEFT) {
     mousePress = mousePos;
     if(ln.drawn && Geometry.pointInsideCircle(ln.P1, 4, mousePos ) ){
        ln.dragging = true;
        ln.dragP1 = true;
        return;
     }
     if(ln.drawn && Geometry.pointInsideCircle(ln.P2, 4, mousePos ) ){
        ln.dragging = true;
        ln.dragP2 = true;
        return;
     }
     if(ln.drawn && Geometry.pointOnLine(ln, mousePos)){
         mousePress.x = mouseX;
         mousePress.y = mouseY;
         ln.dragWhole = true;
         return;
     }
     if (circle.drawn && Geometry.pointOnCircleBorder(circle, mousePos)){
       mousePress.x = mouseX;
       mousePress.y = mouseY;
       circle.resizing = true;
       return;
     }
     if (!circle.drawn && !ln.hovered){
        circle.center.x = mouseX;
        circle.center.y = mouseY;
        return;
     }
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
    if (!circle.drawn && !ln.hovered){
      //draw the circle
      int relX = mouseX;
      int relY = mouseY;
      circle.radius = dist(circle.center.x, circle.center.y, relX, relY);
            
    } else if (ln.drawn && ln.dragWhole){
      /*
      change position of the whole line segment
      */
      Vect2 posDiff = new Vect2(mousePress.x - mouseX, mousePress.y - mouseY);
      ln.P1.subtract(posDiff);
      ln.P2.subtract(posDiff);
      mousePress.x=mouseX;
      mousePress.y=mouseY;
      //println("mp" + mousePress.x + ", " + mousePress.y + " posDiff: " + posDiff.x + ", " + posDiff.y);
      
    }else if (ln.drawn && ln.dragging && ln.dragP1){
      /*
      change position of line segment
      */
      ln.P1.x = mouseX;
      ln.P1.y = mouseY;
    }else if (ln.drawn && ln.dragging && ln.dragP2){
      /*
      change position of another line segment
      */
      ln.P2.x = mouseX;
      ln.P2.y = mouseY;
    }else if (circle.drawn && circle.hovered && !circle.resizing) {
      /*
      move the circle
      */  
      Vect2 DragDiff = new Vect2(mousePress.x - mouseX, mousePress.y - mouseY);
      
      circle.center.subtract(DragDiff);
      mousePress.x=mouseX;
      mousePress.y=mouseY;
      
    }else if (circle.drawn && circle.resizing){
      circle.radius = dist (circle.center.x, circle.center.y, mouseX, mouseY);
    }
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
    ln.dragging = false;
    ln.dragP1 = false;
    ln.dragP2 = false;
    ln.dragWhole = false;
    circle.resizing = false;
  } 
  else if(mouseButton == RIGHT) {
    ln.drawn = true;
    lineMsg = "LINE      A (" + ln.P1.x + ", " + ln.P2.y + "), B (" + ln.P2.x + ", " + ln.P2.y + ")";
    lineTL.setValue(lineMsg);
  }
  
}
