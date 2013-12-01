import java.util.*;
import processing.opengl.*;
import igeo.*;

String dataPath = "/home/janinko/Programování/functional-connectivity/data/";
int barWidth = 20;
int lastBar = -1;

Mask m = new Mask();
Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
VertexList vl;
FaceList fl;
List<BrainPart> parts = new ArrayList<BrainPart>();
float angle = 0;

void setup() 
{
  size(800, 500, IG.GL); 
  noStroke();
  background(0);
  frameRate(2);
  try{
    vl = new VertexList();
    fl = new FaceList();
  }catch(IOException ex){
    throw new RuntimeException(ex);
  }
  Transform t = new Transform(vl, fl);
  t.setCallback(new LogCallback());
  
  IVec[][] cpts1 = new IVec[2][2];
/*
  for(int i=0; i < cpts1.length; i++){
    for(int j=0; j < cpts1[i].length; j++){
      if( (i+j)%2==0 ){ 
        cpts1[i][j] = new IVec(i*5, -j*5-30, (i+j)*2); 
      }
      else{ cpts1[i][j] = new IVec(i*5, -j*5-30, (i+j-1)*2); }
    }
  }
  for(IVec[] v : cpts1){
    println(v);
  }*/
  /*cpts1[0][0] = new IVec(0, -30, 0);
  cpts1[0][1] = new IVec(0, -35, 0);
  cpts1[1][0] = new IVec(5, -30, 0);
  cpts1[1][1] = new IVec(5, -35, 4);
  
  IVertex v1 = new IVertex(0, 0, 0);
  IVertex v2 = new IVertex(0, -35, 0);
  IVertex v3 = new IVertex(5, -30, 0);
  IFace[] fs = new IFace[1];
  fs[0] = new IFace(v1, v2, v3);
  // mesh 1 (cyan)
  new IMesh(cpts1).clr(0,1.,1.);
  new IMesh(fs).clr(1.,0,0);*/
  
  println("START");
  t.toMesh(0).clr(1.0,0,0);
  t.toMesh(1).clr(0,1.,0);
  t.toMesh(2).clr(0,0,1.);
  t.toMesh(3).clr(1.,1.,0);
  t.toMesh(4).clr(0,1.,1.);
  t.toMesh(5).clr(1.,0,1.);
  println("STOP");

  /*for(int i=1; i<=90; i++){
    parts.add(new BrainPart(i, m, rn));
  }*/
}

void draw() 
{
  /*colorMode(RGB);
  background(0);
  
  colorMode(HSB, 90);
  translate(width/2, height/2, 0);
  rotateY(angle);
  
  
  fill(0, 0, 90);
  box(5);
  scale(2);
  translate(-m.w/2, m.h/2, m.d/2);
  
  for(BrainPart part : parts){
    part.draw();
  }
  angle += 0.3;*/
}
