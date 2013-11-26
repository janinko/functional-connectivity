import java.util.*;

String dataPath = "/home/jbrazdil/Programování/functional-connectivity/Projekt/data/";
int barWidth = 20;
int lastBar = -1;

Mask m = new Mask();
Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
List<BrainPart> parts = new ArrayList<BrainPart>();
float angle = 1.5;

void setup() 
{
  size(800, 500, P3D); 
  noStroke();
  background(0);

  for(int i=1; i<=90; i++){
    parts.add(new BrainPart(i, m, rn));
  }
}

void draw() 
{
  colorMode(RGB);
  background(0);
  
  colorMode(HSB, 90);
  translate(width/2, height/2, 0);
  rotateY(angle);
  
  
  fill(0, 0, 90);
  box(5);
  
  translate(-m.w/2, -m.h/2, m.d/2);
  
  for(BrainPart part : parts){
    part.draw();
  }
  angle += 0.1;
}
