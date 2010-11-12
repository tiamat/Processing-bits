static class Geometry {
  
  static private final float accuracy = 2;
  
  public Geometry() {
    
  }

/*returns unit circle quarter position of one point to another, 
considering first point a cnter of a unit cicle.
@param   center - center of imaginery unit circle
@param   checkPoint - relative point

@return 1 - 1st quarter, e.g. right top quarter
@return 2 - 2nd quarter, e.g. left top quarter
@return 3 - 3nd quarter, e.g  left bottom quarter
@return 4 - 4th quarter, e.g  right bottom quarter
@return 0 - checkPoint is on the border of the quarters
*/
static int relativePosition(Vect2 center, Vect2 checkPoint){
  //in the first quarter. Note, in screen coordinates posive Y goes down,
  //and opposite to casual cartesian coordinates. That is why quarters appear to be 
  //vertically reversed.
  if (center.x < checkPoint.x && center.y > checkPoint.y){
    return 4;
  }else if (center.x > checkPoint.x && center.y > checkPoint.y) {
    return 3;
  } else if (center.x > checkPoint.x && center.y < checkPoint.y){
    return 2;
  } else if (center.x < checkPoint.x && center.y < checkPoint.y){
    return 1;
  } else {
    return 0;
  }
}



  /*
  @input cCen - input point
   @input 
   @returns point of line, closest to given point
   method calculates what end of the line is the closest to the point
   */
  static Vect2 closestLineEndToPoint(Vect2 cCen, Vect2 vect1, Vect2 vect2) {
    Vect2 closestPoint = new Vect2();

    if (dist(vect1.x,vect1.y,cCen.x, cCen.y) <= dist(vect2.x,vect2.y, cCen.x, cCen.y)) {
      closestPoint = vect1;
    }
    else {
      closestPoint = vect2;
    }   
    return closestPoint;
  }
  /*
  @returns true if point is inside the circle. 
   @returns false if point is outside the circle.
   */
  static boolean pointInsideCircle( Circle cir, Vect2 pnt) {
    if(dist(cir.center.x, cir.center.y, pnt.x, pnt.y) <= cir.radius - accuracy) {
      return true;
    }
    else {
      return false;
    }
  }
  
  static boolean pointInsideCircle(int cenX, int cenY, float radius, Vect2 pnt){
   if(dist( cenX, cenY, pnt.x, pnt.y ) <= radius - accuracy){
     return true;
   } else {
     return false;
   }
  }
  
  static boolean pointInsideCircle(Vect2 center, float radius, Vect2 pnt){
    if(dist(center.x, center.y, pnt.x, pnt.y) <= radius - accuracy) {
     return true;
   } else {
     return false;
   }
  }
  
  static boolean pointOnCircleBorder(Circle cir, Vect2 pnt){
    float dst = dist(cir.center.x, cir.center.y, pnt.x, pnt.y);
    if (dst <= cir.radius + accuracy && dst >= cir.radius - accuracy) {
          return true;
        }else
          return false;
  }
  
 /*
 @returns true if point belongs to line  
   @return false if not. 
   *
   the function is not mathematically correct and shall be applied only on user interfaces. 
   It's intended to rougly determine if mouse hovers the line
   *
   Point is considered to belong to the line if a distance between 
   point and line is less than 1. The number can be increased due to usability 
   */
  static boolean pointOnLine(Line ln, Vect2 pnt) {
    Vect2 perpIntersection = Space2.closestPointOnLineSegment( pnt, ln.P1, ln.P2 );
    float distance = dist(pnt.x, pnt.y, perpIntersection.x, perpIntersection.y);
    if (distance < accuracy  ) {
      return true;
    } 
    else {
      return false;
    }
  }



  
  static boolean pointOnEndOfLineSegment(Line ln, Vect2 pnt){
    if (Vect2.distance(ln.P1, pnt) < accuracy||  Vect2.distance(ln.P2, pnt) < accuracy){
      return true;
    } else {
      return false;
    }
  }
  /*
  @input Vect2 main - subject of comparison
  @input Vect2[] points
  
  chooses closest point from array of point to the point
  *
  @returns Vect2, 
  *
  static void  Vect2 closesPoint(Vect2 main, Vect2 ppl[]) {
    Vect2 closest = new vect2();
    return closest; 
  }
  */


  /*
   @returns true if one point is rougly close to another point
   @returns false if far
   * 
   this function is designed to be used in mouse-driven UI and checks if mouse hovers point. 
   */
  static boolean pointOnPoint(Point pnt, Vect2 mPos) {
    if (dist(pnt.pos.x, pnt.pos.y, mPos.x, mPos.y ) <  2) {
      return true;
    } 
    else 
      return false;
  }





  static Line parallelLineThhroughPoint(Line ln, Vect2 towards) {
    //   Line newLine = new Line();

    return ln;
  }

  /*
  @returns true if circle and line are intersecting
   false if not intersecting
   */
  static boolean circleRayIntersect(Line ln, Circle circle) {
    //line point A
    float x1 = ln.P1.x;
    float y1 = ln.P1.y;

    //line point B
    float x2 = ln.P2.x;
    float y2 = ln.P2.y;

    //circle center and radius
    float cx = circle.center.x;
    float cy = circle.center.y;
    float cr = circle.radius;

    //intersection points
    Vect2[] intersections;
    intersections = new Vect2[2];

    float dx = x2 - x1;
    float dy = y2 - y1;
    float a = dx * dx + dy * dy;
    float b = 2 * (dx * (x1 - cx) + dy * (y1 - cy));
    float c = cx * cx + cy * cy;
    c += x1 * x1 + y1 * y1;
    c -= 2 * (cx * x1 + cy * y1);
    c -= cr * cr;
    float bb4ac = b * b - 4 * a * c;

    //println(bb4ac);

    if (bb4ac < 0) {  // Not intersecting
      return false;
    }
    else {
      return true;
    }
  }
  /*
  @returns points of circle and ray intersection
   
   CAUTION: method does not check whether circle and rey intersect. If they do not intersect, method won't work.
   */
  static Vect2[] circleRayIntersectPoints(Line ln, Circle circle) {
    //line point A
    float x1 = ln.P1.x;
    float y1 = ln.P1.y;

    //line point B
    float x2 = ln.P2.x;
    float y2 = ln.P2.y;

    //circle center and radius
    float cx = circle.center.x;
    float cy = circle.center.y;
    float cr = circle.radius;

    //intersection points
    Vect2[] intersections;
    intersections = new Vect2[2];

    float dx = x2 - x1;
    float dy = y2 - y1;
    float a = dx * dx + dy * dy;
    float b = 2 * (dx * (x1 - cx) + dy * (y1 - cy));
    float c = cx * cx + cy * cy;
    c += x1 * x1 + y1 * y1;
    c -= 2 * (cx * x1 + cy * y1);
    c -= cr * cr;
    float bb4ac = b * b - 4 * a * c;

    float mu = (-b + sqrt( b*b - 4*a*c )) / (2*a);
    float ix1 = x1 + mu*(dx);
    float iy1 = y1 + mu*(dy);
    mu = (-b - sqrt(b*b - 4*a*c )) / (2*a);
    float ix2 = x1 + mu*(dx);
    float iy2 = y1 + mu*(dy);

    // The intersection points
    intersections[0] = new Vect2(ix1, iy1);
    intersections[1] = new Vect2(ix2, iy2);
    return intersections;
  }
}

