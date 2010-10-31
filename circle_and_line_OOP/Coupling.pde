public class Coupling{
  Coupling(){
  }
  
  void draw(){
    
    //draw perpendicular between circle center and a line
    
  }
  
  void drawCentLinePerp(Vect2 cCen, Vect2 lineA, Vect2 lineB){
      Vect2 intersectionPoint = Geometry.pointAndLineIntersection(cCen, lineA, lineB);
      line(intersectionPoint.x, intersectionPoint.y, cCen.x, cCen.y);
  }
}
