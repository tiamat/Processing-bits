static class Geometry {
  
 public Geometry(){
 }
 
 /*
 method calculates shortest path between point and vector
 */
 static Vect2 pointAndLineIntersection(Vect2 lPoint, Vect2 line1, Vect2 line2){
  Vect2 intersectionPoint= Space2.closestPointOnLineSegment( lPoint, line1, line2 );
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
 
 static boolean pointInsideCircle( Circle cir, Vect2 pnt){
  if(dist(cir.center.x, cir.center.y, pnt.x, pnt.y) <= cir.radius/2){
      return true;
    }else{
      return false;
    } 
 }
 
}
