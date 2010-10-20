

class T1{
  int boldness;        //thickness of the caption
  int canvasSize;      //canvas size is a wideness of T1 logo
  color canvasColor;

  T ts;

  color fontColor;

  int xp, yp;          

  T1() {
    ts = new T();    
  }

  void display(int xpos, int ypos, int th){
    boldness = th;
    canvasSize = boldness*8;
    
    xp = xpos;
    yp = ypos;
    //    canvasColor = color(backgr, 200,200);
    colorMode(HSB, 360, 100, 100);

    pushMatrix();
    ts.display(xp, yp, color( caption, 90, 90), boldness);

    translate (canvasSize+xp*2,canvasSize+yp*2);
    
    rotate(radians(180));

    ts.display(xp,yp+boldness, color( caption, 90, 90), boldness);

    popMatrix();    
  }

 
}

T1 t1 = new T1();
PFont fontA;

void setup(){
  background(60);
  //size(t1.canvasSize+20,t1.canvasSize);
  size(400,400);
  fontA = loadFont("DejaVuSans-12.vlw");
  textFont(fontA);
}

color caption, backgr;

void draw(){
  //HSB s=80 b=80 h
  caption+=2;  
  background(0);
  
  text(mouseX/8, 30, 380);
  
  
  t1.display(0,0,mouseX/8);
  if(caption==360){
    caption=0;
    //     noLoop();
  }
  //saveFrame();

}


