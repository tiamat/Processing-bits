static class Geometry {

  static private final float accuracy = 1;

  static class Position_ {
    static boolean above;
    static boolean below;

    Position_() {
    }
  }
  //static enum _relationalPosition {leftTop, rightTop, leftBottom, rightBottom }
  //static _relationalPosition relationalPosition;



  public Geometry() {
    Position_ position = new Position_();
  }


  /*
 method calculates shortest path between point and vector
   */
  static Vect2 pointAndLineIntersection(Vect2 lPoint, Vect2 line1, Vect2 line2) {
    Vect2 intersectionPoint = Space2.closestPointOnLineSegment( lPoint, line1, line2 );
    return intersectionPoint;
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
    if(dist(cir.center.x, cir.center.y, pnt.x, pnt.y) <= cir.radius) {
      return true;
    }
    else {
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
  static boolean pointOnLine(Line ln, Vect2 pnt) {
    Vect2 intersection = pointAndLineIntersection(pnt, ln.P1, ln.P2);
    float distance = dist(pnt.x, pnt.y, intersection.x, intersection.y);
    if (distance < accuracy  ) {
      return true;
    } 
    else {
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

    //println(bb4ac);
    /*
    if (bb4ac < 0) {  // Not intersecting
     return false;
     }
     else {
     */
    float mu = (-b + sqrt( b*b - 4*a*c )) / (2*a);
    float ix1 = x1 + mu*(dx);
    float iy1 = y1 + mu*(dy);
    mu = (-b - sqrt(b*b - 4*a*c )) / (2*a);
    float ix2 = x1 + mu*(dx);
    float iy2 = y1 + mu*(dy);

    // The intersection points
    //ellipse(ix1, iy1, 10, 10);
    //ellipse(ix2, iy2, 10, 10);
    intersections[0] = new Vect2(ix1, iy1);
    intersections[1] = new Vect2(ix2, iy2);
    return intersections;
    /*
      float testX;
     float testY;
     // Figure out which point is closer to the circle
     if (dist(x1, y1, cx, cy) < dist(x2, y2, cx, cy)) {
     testX = x2;
     testY = y2;
     } 
     else {
     testX = x1;
     testY = y1;
     }
     
     if (dist(testX, testY, ix1, iy1) < dist(x1, y1, x2, y2) || dist(testX, testY, ix2, iy2) < dist(x1, y1, x2, y2)) {
     return true;
     } 
     else {
     return false;
     }
     }*/
  }
}

