import java.util.*;

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

