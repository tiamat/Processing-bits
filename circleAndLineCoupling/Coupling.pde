public class Coupling {
  boolean drawHelpers;              //shows whether to draw helper-lines;
  boolean exists;                   //true if coupling exists
  private boolean radiusSpecified;  //shows whether radius have been specified by user
  float radius;                   //Coupling's radius
  Vect2 center;                   //Coupling ARC's center point
  Vect2 couplingCircleEnd;        //end of coupling arc, laying on the initial circle.
  Vect2 couplingLineEnd;          //end of coupling arc, laying on the initial line

  Coupling() {
    drawHelpers = false;
    radiusSpecified = false;
    couplingCircleEnd = new Vect2();
    couplingLineEnd = new Vect2();
  }

  void setRadius(float rad) {
    radius = rad;
    radiusSpecified = true;
  }


  /*calculates and draws coupling with no radius specified */
  void draw(Line ln, Circle circl, Point pnt) {

    //find intersection between line and perpendicular drawn through circle center. 
    Vect2 A1_CenterLinePerp = Space2.closestPointOnLine(circl.center, ln.P1, ln.P2);

    //finding out angle of the perpendicar, drawn prom the center of the circle
    Vect2 XPar = new Vect2(400,circl.center.y); // lies on X border of the canvas
    Vect2 A1_XPar = Space2.closestPointOnLine(A1_CenterLinePerp, circl.center, XPar);


    float Perp1AngleSin = dist(A1_XPar.x, A1_XPar.y, A1_CenterLinePerp.x, A1_CenterLinePerp.y) / dist(A1_CenterLinePerp.x, A1_CenterLinePerp.y, circl.center.x, circl.center.y);

    float Perp1Angle = asin(Perp1AngleSin);
    println(Perp1Angle);

    Vect2 ellipsePoint = Space2.ellipsePoint( Perp1Angle, circl.radius, circl.radius );
    println(ellipsePoint);

    if (drawHelpers) {
      stroke(229, 238, 250);
      //draw perpendicular between circle center and a line
      line(A1_CenterLinePerp.x, A1_CenterLinePerp.y, circl.center.x, circl.center.y);

      line(A1_CenterLinePerp.x, A1_CenterLinePerp.y, A1_XPar.x, A1_XPar.y);
    }
  }

  /*calculates and draws coupling with radius specified by user*/
  void draw(Line ln, Circle circle, float couplingRad) {
    /*
    1. calculate extended radius (helperRadius)
     2. calculate helperCircle with extended redius
     3. calculate relational position of circle center to line by creatng perpendicular to it (helperPerp)
     4. calculate coordinates of a line (helperLine) , parallel to given line on a distance RADIUS
     5. calculate intersection point (this.coulpling) between helperLine and helperCircle. is is this.coplingCenter
     6. create helperRadius from helperCircle.center to this.coplingCenter
     6. calculate intersection given circle and helperRadius. It is couplingLineCircle
     7. calculate intersection beteween Coupling.radus and couplingLineEnd
     8. draw coupling arc
     */

    //***1
    float extendedRad = circle.radius + couplingRad;
    //***2
    Vect2 helperPerp = Space2.closestPointOnLine(circle.center, ln.P1, ln.P2);

    //***3
    //perp.line slope (or tg lapha)
    float helperPerpM = (circle.center.y - helperPerp.y)/(circle.center.x - helperPerp.x);
    //perp.line B
    //float helperPerpB = helperPerp.y - helperPerpM * helperPerp.x;
    //looking for dots, equally far situated from main line on a distance R
    Vect2 hp1, hp2;
    hp1 = new Vect2(0,0);
    hp2 = new Vect2(0,0);

    hp1.x = couplingRad / sqrt( 1 + sq(helperPerpM) ) + helperPerp.x;
    hp1.y = helperPerpM * (hp1.x - helperPerp.x) + helperPerp.y;

    hp2.x = -1*(couplingRad / sqrt ( 1 + sq ( helperPerpM) ) ) + helperPerp.x;
    hp2.y = helperPerpM * (hp2.x - helperPerp.x) + helperPerp.y;    
    
    
    //***4
    //choose closest one to the center of the initial circle - this one is going to belong to (helperLine)
    Vect2 closestPointForPar = new Vect2();

    if (dist(circle.center.x, circle.center.y, hp1.x, hp1.y) < dist(circle.center.x, circle.center.y, hp2.x, hp2.y)) {
      closestPointForPar = hp1;
    } 
    else {
      closestPointForPar = hp2;
    }

    //substituting formula for line, parallel to initial line and going through (closestPointForPar)
    float ParLineM = -1 / helperPerpM;          //slope is perpendicular to helper line
    float ParLineB = closestPointForPar.y - ParLineM * closestPointForPar.x;//B is substituted by knowing point and slope (b = y - k*x)

    //substituing second point on parallel line to draw the line grahically
    Vect2 secParPoint = new Vect2(0,0);
    Vect2 secParPoint2 = new Vect2(0,0);
        
    if ( ParLineM < 0) {
      secParPoint = new Vect2(0,ParLineB);
      secParPoint2 = new Vect2((-1)*ParLineB/ParLineM,0);
    }  else if ( ParLineM > 0 ) {
        secParPoint = new Vect2(width,ParLineM*width + ParLineB);
        secParPoint2 = new Vect2((-1)*ParLineB/ParLineM,0);
    }

    //*** 5
    //creating helper objects to be used for their intersection calculation. 
    Line helperLine = new Line(secParPoint,secParPoint2);
    Circle helperCircle = new Circle(circle.center, extendedRad);
    
    Vect2[] helpersIntersections;
    helpersIntersections = new Vect2[2];
    
    helpersIntersections[0] = new Vect2();
    helpersIntersections[1] = new Vect2();    
    
      
    
    //checking for helpers intersection
    if(Geometry.circleRayIntersect(helperLine, helperCircle)) {
      this.exists = true;
      helpersIntersections = Geometry.circleRayIntersectPoints(helperLine, helperCircle);
      
      //choosing helpersIntersections[0] for coupling center. helpersIntersections[1] can be chosen also. 
      center = helpersIntersections[0];
      
      //*** 6 
      Vect2[] couplingCircleInt = new Vect2[2];
      couplingCircleInt[0] = new Vect2();
      couplingCircleInt[1] = new Vect2();
      
      
      //creating helper line 
      Line circleCenCouplingRad = new Line(circle.center, center);
      
      //finding intersections between initial circle center and Coupling radius
      couplingCircleInt = Geometry.circleRayIntersectPoints(circleCenCouplingRad, circle);
            
      //choosing closest intersection for 
      if (dist(couplingCircleInt[0].x, couplingCircleInt[0].y, center.x, center.y) < dist(couplingCircleInt[1].x, couplingCircleInt[1].y, center.x, center.y)){
        couplingCircleEnd = couplingCircleInt[0];
      } else {
        couplingCircleEnd = couplingCircleInt[1];
      }
      
      couplingLineEnd = Space2.closestPointOnLine(center, ln.P1, ln.P2);
      radius = dist(couplingLineEnd.x, couplingLineEnd.y, center.x, center.y);

      //intersection angle calculation
      float tana = (center.y - couplingLineEnd.y )/(center.x- couplingLineEnd.x);  
      float lineRadAngle = atan(tana);      
      float tanb = (center.y - couplingCircleEnd.y)/(center.x - couplingCircleEnd.x);
      float circleRadAngle = atan(tanb);

      //drawing coupling (YEEAH!)
      stroke(247, 128, 0);
      
      //println("Circle angle : " + circleRadAngle + " line angle " + lineRadAngle);
      //if line tangent is negative
      if(ln.slope < 0){
        //if circle is above the line, i.e line is in 1st qurter
        if(Geometry.relativePosition(center,couplingLineEnd) ==1 ){
          //if circle end is in 1st quarter
          if(Geometry.relativePosition(center,couplingCircleEnd) == 1 || Geometry.relativePosition(center,couplingCircleEnd) == 4){  
            arc (center.x, center.y, radius, radius, 0 + lineRadAngle, 0 + circleRadAngle);  
          }
          //if circle end is in 2nd quarter
          if(Geometry.relativePosition(center,couplingCircleEnd) == 2 || Geometry.relativePosition(center,couplingCircleEnd) == 3){  
            arc (center.x, center.y, radius, radius, 0 + lineRadAngle, PI + circleRadAngle); 
          }
        
        //if circle is below the line, e.g line is in 3rd qurter
        }else if (Geometry.relativePosition(center,couplingLineEnd) == 3 ){
          //if circle radius is in 2nd quarter:
          if(Geometry.relativePosition(center,couplingCircleEnd) == 2 || Geometry.relativePosition(center,couplingCircleEnd) == 3){
            arc (center.x, center.y, radius, radius, PI + circleRadAngle , PI +  lineRadAngle); 
          }    
          //if cirle radius is in 1st quarter
          if(Geometry.relativePosition(center,couplingCircleEnd) == 1 || Geometry.relativePosition(center,couplingCircleEnd) == 4){
            arc (center.x, center.y, radius, radius, 0 + circleRadAngle , PI +  lineRadAngle);      
          }
        }
        
      //if line tangent is positive
      }else if(ln.slope > 0){
        //if circle is below the line
        if(Geometry.relativePosition(center,couplingLineEnd) == 4 ){
          //if circle radius is in 2nd quarter:
          if(Geometry.relativePosition(center,couplingCircleEnd) == 2  || Geometry.relativePosition(center,couplingCircleEnd) == 3){
            arc (center.x, center.y, radius, radius, 0 + lineRadAngle, PI + circleRadAngle ); 
          }    
          //if cirle radius is in 1st quarter
          if(Geometry.relativePosition(center,couplingCircleEnd) == 1 || Geometry.relativePosition(center,couplingCircleEnd) == 4){
            arc (center.x, center.y, radius, radius, 0 + lineRadAngle, 0 + circleRadAngle);      
          }     
          
          
        //if circle is above the line
        } else if (Geometry.relativePosition(center,couplingLineEnd) == 2){
          //if circle radius is in 1st quarter:
          if(Geometry.relativePosition(center,couplingCircleEnd) == 1 || Geometry.relativePosition(center,couplingCircleEnd) == 4){
            arc (center.x, center.y, radius, radius, 0 + circleRadAngle, PI + lineRadAngle ); 
          }    
          //if cirle radius is in 2nd quarter
          if(Geometry.relativePosition(center,couplingCircleEnd) == 2 || Geometry.relativePosition(center,couplingCircleEnd) == 3){
            arc (center.x, center.y, radius, radius, PI + circleRadAngle, PI + lineRadAngle);        
          }
        }
       // arc (center.x, center.y, radius, radius, lineRadAngle, circleRadAngle );      //positive tangent, circle below
      //arc (center.x, center.y, radius, radius, circleRadAngle, lineRadAngle + PI);    //positive tangent, circle above +++
      }
      
      
      
    } else {
      this.exists = false;
      //println("ERROR: Coupling can not be drawn. Helper circle and helper line  do not have intersection points!!!");
      return;
    }

    
    if (drawHelpers) {
      stroke(200, 200, 200);
      strokeWeight(1);
      noFill();
      ellipse(circle.center.x, circle.center.y, extendedRad, extendedRad); //helper circle
      line(circle.center.x, circle.center.y, helperPerp.x, helperPerp.y);  //perpendicular from circel center to initial line
      
      ellipse(closestPointForPar.x,closestPointForPar.y,2,2);              //intersection between perp. and the initial circle
      //println("Parallel line. tg:  " +  ParLineM + " B: " + ParLineB);
      line(secParPoint.x, secParPoint.y, secParPoint2.x, secParPoint2.y);  //helper line, perallel to initial
      
      ellipse(helpersIntersections[0].x, helpersIntersections[0].y, 2,2);  //intersection 1 between helpers (line and circle)
      ellipse(helpersIntersections[1].x, helpersIntersections[1].y, 2,2);  //intersection 2 between helpers (line and circle)
      line(circle.center.x, circle.center.y, center.x, center.y);          //line between circle center and intersection 1
      ellipse(couplingCircleEnd.x, couplingCircleEnd.y, 2,2);              //Coupling and circle intersection
      line(couplingLineEnd.x, couplingLineEnd.y, center.x, center.y);
      ellipse(couplingLineEnd.x, couplingLineEnd.y,2,2);
    }
  }
}

