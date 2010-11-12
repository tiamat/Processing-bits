class Point{
 
 boolean userSet;
 //int x,y;
 Vect2 pos;      //position
 int diameter;    //thickness of the dot
 int aShift;    //indicates how far point is located from A 
 boolean hovered;//shows if mouse is above the point
 Vect2 mousPos;
 boolean dragging;
 
 Point(){
   pos = new Vect2(0,0);
   userSet = false;
   diameter = 2;
 } 
 
 Point(float px, float py){
   pos = new Vect2(0,0);
   hovered = false;
   diameter = 2;
   pos.x = px;
   pos.y = py; 
 }
 
 void draw(){
   if (hovered) {
     stroke(255,255,0);
     ellipse(pos.x, pos.y, diameter+1, diameter+1);
   } else {
     stroke(0,0,205);
     ellipse(pos.x, pos.y, diameter, diameter);
   }
 }
 
 void draw(float px, float py){
   pos.x = px;
   pos.y = py;
   if (hovered) {
     stroke(255,255,0);
     ellipse(pos.x, pos.y, diameter+1, diameter+1);
   } else {
     stroke(0,0,205);
     ellipse(pos.x, pos.y, diameter, diameter);
   }
 }
 /*
 moves mouse along the line it belongs to, setting precision meanwhile
 */
 void move(Line ln, int newX, int newY){
   // find projection of new mouse position to the line, point belogs to
   mousPos = new Vect2(newX, newY);
   pos = Space2.closestPointOnLineSegment(mousePos, ln.P1, ln.P2);
   println(mousePos);
   println(pos);
   // calculate distance between projection and line.P1
   
   //update precision
 }
 
 //draws point in the middle of the given line
 void drawMiddle(Line ln){
   pos = Vect2.midpoint(ln.P1, ln.P2);
 }
}
