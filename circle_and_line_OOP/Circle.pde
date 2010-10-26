public class Circle {
  
  public boolean drawn;
  public boolean hovered;  //if mouse is on top of the circle
  public float radius;
  public Vect2 center;
  
  
  Circle(){
    center = new Vect2(0,0);
    drawn = false;
    radius = 0;
    hovered = false;
  }
  
  void draw(){
    stroke(33, 107, 22);
    if (hovered){
      strokeWeight(3);
    } else {
      strokeWeight(2);
    }
    ellipse(center.x, center.y, radius, radius);
  }
  
  
}
