import java.util.*;
import processing.opengl.*;
import igeo.*;

String dataPath = "/home/jbrazdil/Programování/functional-connectivity/data/";

Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
BrainInfo bi = new BrainInfo();
List<BrainPart> parts = new ArrayList<BrainPart>();
Set<Connectivity> connections; 
IPane persp;

void setup(){
  size(900, 900, IG.GL);
  persp = IG.perspectivePane();
  IG.fill();
}

int fc=0;
boolean loaded = false;
BrainPart selected = null;
IMesh brain;
void draw(){
  switch(fc){
    case 0:
        fill(0);
        textSize(26);
        textAlign(CENTER);
        text("LOADING", width/2, height/ 2);
        fc++; return;
    case 1:
      IG.open(dataPath + "brain/part_0d.obj");
      brain = IG.meshes()[0];
      brain.hsb(0.1, 0.6, 0.7, 0.1);
      fc++; return;
    case 92: connections = Connectivity.generate(a, parts); fc++; return;
    case 93: genRepreNodes(); fc++; return;
    case 94: genEdges(); fc++; return;
    case 95: loaded = true; fc++; return;
  }
  if(fc > 1 && fc <= 91){
    genPart(fc-2);
    fc++; 
  }
  if(fc > 1) brain.show();
  if(selected != null){
    fill(0);
    textSize(15);
    textAlign(LEFT);
    text(selected.info, 20, 20);
    return;
  }
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
  selected = null;
  
  List<BrainPart> nearParts = new ArrayList<BrainPart>();
  
  IView v = persp.getView();
  for(BrainPart part : parts){
    part.deselected();
    IVec coor = v.convert(part.getRepreNodeCenter());
    float dist = mouseDist(coor.x, coor.y);
    if(dist < 20){
      nearParts.add(part);
    }
  }
  for(Connectivity conn : connections){
    conn.deselected();
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
  selected = nearPart;
}

BrainOBJ b = new BrainOBJ();

void genPart(int id){
  IMesh mesh = b.getOnePart(id);
  parts.add(new BrainPart(id+1, mesh, rn, bi));
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
