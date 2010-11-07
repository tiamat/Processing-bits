public class Line{
  /*
  Draws line and point for Coupling 
  
  Point is located on the closest dot of the line to the circle center by default. 
  If user sets point position manually, point is relocated. 
  
  */
  
  boolean drawn;         //indicates whether line have been drawn by user
  boolean hovered;
  float slope;           //line's tg
  float b;
  
  Vect2 P1, P2;          //points of the line in vector form
  
  Line(){
    drawn = false;
    hovered = false;
    P1 = new Vect2();
    P2 = new Vect2();
  }
  
  Line(Vect2 p1, Vect2 p2){
    drawn = false;
    hovered = false;
    P1 = p1;
    P2 = p2;
    slope = (P2.y - P1.y)/(P2.x - P1.x);
  }
  
  
  void draw(){
    slope = (P2.y - P1.y)/(P2.x - P1.x);
    b = P2.y - slope * P2.x;
    stroke(229, 0, 0);
    if (hovered){
      strokeWeight(3);
    } else {
      strokeWeight(2);
    }
    noFill();
    line(P1.x, P1.y, P2.x, P2.y);
    strokeWeight(1);
    //println("Original line's slope is: " + slope + "line's B is: " + b);
  }

  public void setCouplingPoint(Vect2 point){
  }
  
 /* boolean pointInside(int px, int py){
      return false;
  }*/
}
