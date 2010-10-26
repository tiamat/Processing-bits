class Point{
 
 boolean userSet;
 int x,y;
 int diameter;    //thickness of the dot
 int aShift;    //indicates how far point is located from A 
 boolean hovered;//shows if mouse is above the point
 
 Point(){
   userSet = false;
   diameter = 2;
 } 
 
 Point(int px, int py){
   diameter = 2;
   x = px;
   y = py; 
 }
 
 void draw(){
   stroke(153, 50, 0);
   ellipse(x,y, diameter, diameter);
 }
 
 void draw(float px, float py){
   stroke(153, 50, 0);
   ellipse(px, py, diameter, diameter);
 }
 
}
