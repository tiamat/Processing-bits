public class Coupling{
  boolean drawAll;
  
  Coupling(){
    drawAll = false;
  }
  
  void draw(){
    
    //draw perpendicular between circle center and a line
    
  }
  
  void draw(Line ln, Circle circl, Point pnt){
    stroke(229, 238, 250);
    //find intersection between line and perpendicular drawn through circle center. 
    Vect2 A1_CenterLinePerp = Space2.closestPointOnLine(circl.center, ln.P1, ln.P2);
    
    //draw perpendicular between circle center and a line
    line(A1_CenterLinePerp.x, A1_CenterLinePerp.y, circl.center.x, circl.center.y);
    
    //finding out angle of the perpendicar, drawn prom the center of the circle
    Vect2 XPar = new Vect2(400,circl.center.y); // lies on X border of the canvas
    Vect2 A1_XPar = Space2.closestPointOnLine(A1_CenterLinePerp, circl.center, XPar);
    
    line(A1_CenterLinePerp.x, A1_CenterLinePerp.y, A1_XPar.x, A1_XPar.y);
    float Perp1AngleSin = dist(A1_XPar.x, A1_XPar.y, A1_CenterLinePerp.x, A1_CenterLinePerp.y) / dist(A1_CenterLinePerp.x, A1_CenterLinePerp.y, circl.center.x, circl.center.y);
    
    float Perp1Angle = asin(Perp1AngleSin);
    println(Perp1Angle);
    
    Vect2 ellipsePoint = Space2.ellipsePoint( Perp1Angle, circl.radius, circl.radius );
    println(ellipsePoint);
    
  }
  
}
