static class Geometry {
 
 static private final float accuracy = 1;
 
 public Geometry(){
 }
 
 /*
 method calculates shortest path between point and vector
 */
 static Vect2 pointAndLineIntersection(Vect2 lPoint, Vect2 line1, Vect2 line2){
  Vect2 intersectionPoint = Space2.closestPointOnLineSegment( lPoint, line1, line2 );
  return intersectionPoint;
 }
 
 /*
 method calculates what end of the line is the closest to the point
 */
 static Vect2 closestLineEndToPoint(Vect2 cCen, Vect2 vect1, Vect2 vect2){
   Vect2 closestPoint = new Vect2();
   
   if (dist(vect1.x,vect1.y,cCen.x, cCen.y) <= dist(vect2.x,vect2.y, cCen.x, cCen.y)){
     closestPoint = vect1;
   }else{
     closestPoint = vect2;
   }   
   return closestPoint;
 }
 /*
 returns true if point is inside the circle. 
 returns false if point is outside the circle.
 */
 static boolean pointInsideCircle( Circle cir, Vect2 pnt){
  if(dist(cir.center.x, cir.center.y, pnt.x, pnt.y) <= cir.radius/2){
      return true;
    }else{
      return false;
    } 
 }
 /*
 @returns true if point belongs to line  
 @returns false if not. 
 *
 the function is not mathematically correct and shall be applied only on user interfaces. 
 It's intended to rougly determine if mouse hovers the line
 *
 Point is considered to belong to the line if a distance between 
 point and line is less than 1. The number can be increased due to usability 
 */
 static boolean pointOnLine(Line ln, Vect2 pnt){
   Vect2 intersection = pointAndLineIntersection(pnt, ln.P1, ln.P2);
   float distance = dist(pnt.x, pnt.y , intersection.x, intersection.y);
   if (distance < accuracy  ){
     return true;
   } else {
   return false;
   }
 }
 /*
 @returns true if one point is rougly close to another point
 @returns false if far
 * 
 this function is designed to be used in mouse-driven UI and checks if mouse hovers point. 
 */
 static boolean pointOnPoint(Point pnt, Vect2 mPos){
   if (dist(pnt.pos.x, pnt.pos.y, mPos.x, mPos.y ) <  2){
     return true;
   } else 
     return false;
 }
}
