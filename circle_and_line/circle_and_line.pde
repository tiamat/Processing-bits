int circleCenX,circleCenY;  //circle
float circleRad;              //radius of the circle
boolean circleDrawn;        //if curcle have already been drawn
boolean circleDrawing;      //true while circle is drawn by mouse gesture

int lineAX, lineAY,
lineBX, lineBY;//line coordinates respectively
boolean lineDrawn;      //if line have already been drawn
boolean lineDrawing;    //true while line is 
//in drawing process by mouse gesture

void setup() {
  size(400,400);
  circleDrawn = false;
  lineDrawn = false;
  circleDrawing = false;
  lineDrawing = false;
  background(255,255,255);
  smooth();
}


void draw() {
  background(255,255,255);
  drawCircle();
  drawLine();
  drawConjugation();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    //if(!circleDrawn){
    circleDrawing = true;
    circleCenX = mouseX;
    circleCenY = mouseY;
    //}
  } 
  else if(mouseButton == RIGHT) {
    //if(!lineDrawn){
    lineDrawing = true;
    lineAX = mouseX;
    lineAY = mouseY;
    lineBX = mouseX;
    lineBY = mouseY;
    //}
  }
}

void mouseHover() {
}

void mouseDragged() {
  if(mouseButton == LEFT) {
    //if(!circleDrawn){
    int relX = mouseX;
    int relY = mouseY;
    circleRad = dist(circleCenX, circleCenY, relX, relY)*2;
    //}
  } 
  else if(mouseButton == RIGHT) {
    //  if(!lineDrawn){
    lineBX = mouseX;
    lineBY = mouseY;
  }
  //}
}

void mouseReleased() {
  if(mouseButton == LEFT) {
    circleDrawn = true;
    circleDrawing = false;
  } 
  else if(mouseButton == RIGHT) {
    lineDrawn = true;
    lineDrawing = false;
  }
}

//function draws circle 
void drawCircle() {
  stroke(33, 107, 22);
  strokeWeight(2);
  ellipse(circleCenX, circleCenY, circleRad,circleRad );
}

//draws line
void drawLine() {
  stroke(229, 0, 0);
  strokeWeight(2);
  line(lineAX,lineAY, lineBX,lineBY);
}


void drawConjugation() {
  /*
  //find end of the line closest to circle
   float lineClosestPointX, lineClosestPointY;
   if (dist(lineAX,lineAY,circleCenX, circleCenY) <= dist(lineBX,lineBY,circleCenX,circleCenY)){
   lineClosestPointX = lineAX;
   lineClosestPointY = lineAY;
   }else{
   lineClosestPointX = lineBX;
   lineClosestPointY = lineBY;
   }
   strokeWeight(3);
   stroke(255,255,0);
   ellipse(lineClosestPointX, lineClosestPointY,3,3);*/

  //find perpendicular intersection point between 
  //given line and line drawn from the center of the circle. 

  //draw perpendicular from circle center to extended line

  //draw line from
}

