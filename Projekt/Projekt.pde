import java.util.*;
import processing.opengl.*;
import igeo.*;
import saito.objloader.*;

String dataPath = "/home/janinko/Programování/functional-connectivity/data/";
int barWidth = 20;
int lastBar = -1;

Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
List<BrainPart> parts = new ArrayList<BrainPart>();
Set<Connectivity> connections; 
float angle = 0;
IPane persp;

void setup(){
  size(900, 900, IG.GL);
  persp = IG.perspectivePane();
  //IGridPanel grid = ((IGridPanel)IG.cur().panel);
  //grid.gridPanes[1][0] = new MyPane(grid.gridPanes[1][0]);
  IG.fill();
  
  
  textAlign(CENTER);
}

OBJModel model;
BoundingBox bbox;
void setupobj(){
  size(900, 900, OPENGL);
  model = new OBJModel(this, dataPath + "parts/parts_0m.obj", QUADS);
  model.enableDebug();
 
  model.scale(0.4);
  model.translateToCenter();
  bbox = new BoundingBox(this, model);
}

void drawobj(){
  background(128);
  lights();
  translate(width/2, height/2, 0);
  rotateY(radians(frameCount)/2);
  
  for(int i = -1; i < 2; i ++){
    pushMatrix();
    translate(0,0,i*bbox.getWHD().z);
    
    model.draw();
    popMatrix();
  }
  
  noFill();
  stroke(255,0,255);
  bbox.draw();
  noStroke();
}

int fc=0;
boolean loaded = false;
void draw(){
  switch(fc){
    case 0:
        fill(0);
        textSize(26);
        text("LOADING", width/2, height/ 2);
        fc++; return;
    case 1: genParts(); fc++; return;
    case 2: connections = Connectivity.generate(a, parts); fc++; return;
    case 3: genRepreNodes(); fc++; return;
    case 4: genEdges(); fc++; return;
    case 5: loaded = true; fc++; return;
  }
  /*if(fc > 0 && fc <= 90){
    genPart(fc-1);
    fc++; 
  }*/
  
}

float mouseDist(double x, double y){
  return dist(mouseX, mouseY, (float) x, (float) y);
}

double partDist(BrainPart part, IView v){
  return v.pos.dist(part.getRepreNodeCenter());
}

IPane ppane = null;
void mouseClicked(){
  if(!loaded) return; // scene is not loaded
  
  List<BrainPart> nearParts = new ArrayList<BrainPart>();
  
  IView v = persp.getView();
  for(BrainPart part : parts){
    IVec coor = v.convert(part.getRepreNodeCenter());
    float dist = mouseDist(coor.x, coor.y);
    if(dist < 20){
      nearParts.add(part);
    }
  }
  if(nearParts.isEmpty()) return;
  BrainPart nearPart = nearParts.get(0);
  if(nearParts.size() > 1){
    double min = partDist(nearPart, v);
    for(BrainPart part : nearParts){
      if(min > partDist(part, v)){
        nearPart = part;
        min = partDist(part, v);
      }
    }
  }
  nearPart.onClicked();
}

BrainOBJ b = new BrainOBJ();
void genParts(){
BrainOBJ b = new BrainOBJ();
  for(int i=0; i<90; i++){
    IMesh mesh = b.getPart(i);
    mesh.hsb(((double)i)/90.0, 0.7, 0.4, 0.1);
    parts.add(new BrainPart(i+1, mesh, rn));
  }
}

void genPart(int id){
  IMesh mesh = b.getOnePart(id);
  mesh.hsb(((double)id)/90.0, 0.7, 0.4, 0.1);
  parts.add(new BrainPart(id+1, mesh, rn));
}

void genRepreNodes(){
  for(BrainPart part : parts){
    part.genRepreNode();
  }
}

void genEdges(){
  for(Connectivity conn : connections){
    conn.genEdge();
  }
}
