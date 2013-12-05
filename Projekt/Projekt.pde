import java.util.*;
import processing.opengl.*;
import igeo.*;

String dataPath = "/home/jbrazdil/Programování/functional-connectivity/data/";
int barWidth = 20;
int lastBar = -1;

Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
List<BrainPart> parts = new ArrayList<BrainPart>();
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

int fc=0;
void draw(){
  switch(fc){
    case 0:
        fill(0);
        textSize(26);
        text("LOADING", width/2, height/ 2);
        fc++; return;
    case 91: genRepreNodes(); fc++; return;
  }
  if(fc > 0 && fc <= 90){
    genPart(fc-1);
    fc++; 
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
  if(fc < 92) return; // scene is not loaded
  
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
  for(int i=0; i<90; i++){
    IMesh mesh = b.getOnePart(i);
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
