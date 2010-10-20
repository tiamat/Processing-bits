class T{
 int tWidth;            //calculated parameter of T width
 int tHeight;           //calculated parameter of T height
 
 public int tBoldness;          //Base scale of letter size
                         //T is made out of cubes. 
                         //It is 4 boldness wide and 7 boldness tall.
 
 color tColor;
 
 
 boolean colorShift;
 
 int xp, yp;            //position of T letter inside the frame
 
 T(){
   tBoldness = 20;  
 }
 
 T(int boldness){
   tBoldness = boldness;   
 }
  
 void display(int xpos, int ypos, color col, int bld){
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


  



