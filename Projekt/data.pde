import java.util.*;

class Mask{
  String filePath = dataPath + "simple_mask.h5"; 
  String objectPath = "/home/eb/work/MUNI/PA055/projekt/simple_mask.nii";
  
  int w, h, d;
  MDFloatArray data;
    
  
  Mask(){
    println(filePath);
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
    return new Position(data.get(0,x),data.get(1,x),data.get(2,x));
  }
  
}

