import java.util.*;

int barWidth = 20;
int lastBar = -1;

String dataPath = "/home/xbrazdi1/PA055/Projekt/data/";

class Mask{
  String filePath = dataPath + "mask.h5"; 
  String objectPath = "results/aal/to_processing/aal_atlas";
  
  int w, h, d;
  MDFloatArray data;
    
  
  Mask(){
    IHDF5Reader r = HDF5Factory.openForReading(filePath);
    
    data = r.float32().readMDArray(objectPath);
    System.out.println(data);
    int[] dimensions = data.dimensions();
    w = dimensions[0];
    h = dimensions[1];
    d = dimensions[2];
    println("w: " + w + "; h: " + h + "; d: " + d);
  }
  
  float get(int x, int y, int z){
    return data.get(x, y, z);
  }
  
}

class Position{
  int x, y, z;
  Position(int x, int y, int z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Adjectance{
  String filePath = dataPath + "repre_nodes.h5"; 
  String objectPath = "results/aal/to_processing/adjacency_matrix";
  
  int w, h;
  MDFloatArray data;
    
  
  Adjectance(){
    IHDF5Reader r = HDF5Factory.openForReading(filePath);
    
    println(r.getDataSetInformation(objectPath));
    
    data = r.float32().readMDArray(objectPath);
    System.out.println(data);
    int[] dimensions = data.dimensions();
    w = dimensions[0];
    h = dimensions[1];
    println("w: " + w + "; h:" + h);
  }
  
  float get(int x, int y){
    return data.get(x,y);
  }
  
}

class RepreNodes{
  String filePath = dataPath + "repre_nodes.h5"; 
  String objectPath = "../../results/aal/to_processing/nodes_indices";
  
  int w;
  MDFloatArray data;
    
  
  RepreNodes(){
    IHDF5Reader r = HDF5Factory.openForReading(filePath);
    
    println(r.getDataSetInformation(objectPath));
    
    data = r.float32().readMDArray(objectPath);
    System.out.println(data);
    int[] dimensions = data.dimensions();
    w = dimensions[1];
    println("w: " + w);
  }
  
  Position get(int x){
    //return new Position(data.get(0,x),data.get(1,x),data.get(2,x));
    return null;
  }
  
}

Mask m = new Mask();
Adjectance a = new Adjectance();
RepreNodes rn = new RepreNodes();
float angle = 1.5;

void setup() 
{
  size(800, 500, P3D); 
  noStroke();
  background(0);
}

void drawA(){
  background(0);
  
  translate(width/2, height/2, 0);
  rotateY(angle);
  
  translate(-50,-50,0);
  fill(200,20,20);
  stroke(0,20,0);
  box(25);
  
  translate(100,100,0);
  fill(20,20,200);
  stroke(0,20,0);
  box(25);
  
  
  translate(0,100,0);
  fill(20,200,20);
  stroke(0,20,0);
  box(25);
  
  angle += 0.01;
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
  
  translate(-m.w, +m.h, -m.d);
  
  float max = -99999;
  float min  = 99999;
  for(int depth = 0; depth < m.d; depth++){
   translate(0 , 0, 2);
    for(int x = 0; x < m.w; x++){
      translate(0,-2,0);
      for(int y = 0; y < m.h; y++){
        translate(2,0,0);
        float dato = m.get(x,y,depth);
        if(dato < min){
          min = dato;
        }
        if(dato > max){
          max = dato;
        }
        if(dato <= 0.01) continue;
        fill(dato, 90, 90, 30);
        box(2);
      }
      translate(-2*m.h, 0, 0);
    }
    translate(0, 2*m.w, 0);
  }
  //println("Min: " + min + "; Max: " + max);
  angle += 0.1;
}
