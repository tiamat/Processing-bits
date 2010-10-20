import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class t1 extends PApplet {



class T1{
  int boldness;        //thickness of the caption
  int canvasSize;      //canvas size is a wideness of T1 logo
  int canvasColor;

  T ts;

  int fontColor;

  int xp, yp;          

  T1() {
    ts = new T();    
  }

  public void display(int xpos, int ypos, int th){
    boldness = th;
    canvasSize = boldness*8;
    
    xp = xpos;
    yp = ypos;
    //    canvasColor = color(backgr, 200,200);
    colorMode(HSB, 360, 100, 100);

    pushMatrix();
    ts.display(xp, yp, color( caption, 90, 90), boldness);

    translate (canvasSize+xp*2,canvasSize+yp*2);
    
    rotate(radians(180));

    ts.display(xp,yp+boldness, color( caption, 90, 90), boldness);

    popMatrix();    
  }

 
}

T1 t1 = new T1();
PFont fontA;

public void setup(){
  background(60);
  //size(t1.canvasSize+20,t1.canvasSize);
  size(400,400);
  fontA = loadFont("DejaVuSans-12.vlw");
  textFont(fontA);
}

int caption, backgr;

public void draw(){
  //HSB s=80 b=80 h
  caption+=2;  
  background(0);
  
  text(mouseX/8, 30, 380);
  
  
  t1.display(0,0,mouseX/8);
  if(caption==360){
    caption=0;
    //     noLoop();
  }
  //saveFrame();

}


class T{
 int tWidth;            //calculated parameter of T width
 int tHeight;           //calculated parameter of T height
 
 public int tBoldness;          //Base scale of letter size
                         //T is made out of cubes. 
                         //It is 4 boldness wide and 7 boldness tall.
 
 int tColor;
 
 
 boolean colorShift;
 
 int xp, yp;            //position of T letter inside the frame
 
 T(){
   tBoldness = 20;  
 }
 
 T(int boldness){
   tBoldness = boldness;   
 }
  
 public void display(int xpos, int ypos, int col, int bld){
   tBoldness = bld;
   tWidth = 3 * tBoldness;
   tHeight = 5 * tBoldness;
   xp = xpos + tBoldness/2;    //padding
   yp = ypos + tBoldness;      //padding
   tColor = col;
   
   rectMode(CENTER);
   //background
   fill(0);
   noStroke();
   rect(xp+tWidth/2,yp+tHeight/2, tWidth + tBoldness, tHeight + 2 * tBoldness);
   
   //top horisontal
   noStroke();
   colorMode(HSB);
   fill(tColor);
   rect(xp + tWidth/2, yp + tBoldness/2, tWidth, tBoldness);
   
   //vertical
   rect(xp + tWidth/2, yp + tHeight/2, tBoldness, tHeight);
   
   //bottom horisontal
   rect(xp + tWidth/2 + tBoldness/2, yp + tHeight - tBoldness/2 , tBoldness*2, tBoldness);
 }
}


  




  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "t1" });
  }
}
