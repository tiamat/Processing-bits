public class Line{
  /*
  Draws line and point for Coupling 
  
  Point is located on the closest dot of the line to the circle center by default. 
  If user sets point position manually, point is relocated. 
  
  */
  
  boolean drawn;         //indicates whether line have been drawn by user
  boolean hovered;
  
  Vect2 P1, P2;          //points of the line in vector form
  Vect2 couplingPoint;
  
  Line(){
    drawn = false;
    P1 = new Vect2();
    P2 = new Vect2();
  }
  
  void draw(){
    stroke(229, 0, 0);
    strokeWeight(2);
    line(P1.x, P1.y, P2.x, P2.y);
  }

  public void setCouplingPoint(Vect2 point){
  }
  
 /* boolean pointInside(int px, int py){
      return false;
  }*/
}
