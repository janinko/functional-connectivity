import java.util.*;

class Position{
  float x, y, z;
  Position(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class Adjectance{
  String filePath = dataPath + "adj_matrix.h5"; 
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
  
  float dx = 110.5;
  float dy = 90.5;
  float dz = 91.5;
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
    return new Position(data.get(1,x) -dx, data.get(0,x) -dy,data.get(2,x) -dz);
  }
  
}

class BrainOBJ{
  
  BrainOBJ(){
    IG.open(dataPath + "parts/partsd.obj");
    
  }
  
  IMesh getPart(int id){
    return IG.meshes()[id];
  }
  
  IMesh getOnePart(int id){
    IG.open(dataPath + "parts/part_"+id+".obj");
    return IG.meshes()[id];
  }
}

