public class Line{
  /*
  Draws line for coupling
  
  Point is located on the closest dot of the line to the circle center by default. 
  If user sets point position manually, point is relocated. 
  */
  
  boolean drawn;         //indicates whether line have been drawn by user
  boolean hovered;       //indicates whether line is hovered by mouse
  boolean dragging;      //shows that line is dragging now
  boolean dragP1;    //p1 is in relocation process
  boolean dragP2;    //p2 is in relocation process
  boolean dragWhole; //all segment is in relocation process
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
    
    if (hovered){
      strokeWeight(3);
      stroke(229, 100, 0);
      ellipse(P1.x, P1.y, 2,2);
      ellipse(P2.x, P2.y, 2,2);
    } else {
      strokeWeight(2);
    }
    noFill();
    stroke(229, 0, 0);
    line(P1.x, P1.y, P2.x, P2.y);
    strokeWeight(1);
    //println("Original line's slope is: " + slope + "line's B is: " + b);
  }

  public void setCouplingPoint(Vect2 point){
  }
}
