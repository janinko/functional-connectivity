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

class VertexList{
  MLStructure struct;
 
  VertexList() throws IOException{
    MatFileReader mfr = new MatFileReader(dataPath + "vertexlist.mat");
    struct = (MLStructure) mfr.getMLArray("V");
    println("#################");
    println(struct);
    println("#################");
    println(struct.contentToString());
    println("#################");
    println(struct.getField("vertexlist", 0));
    println("#################");
    println(countVertices(1));
    println(getVertex(1,1));
    println(getVertex(1,6940));
    println(getVertex(1,6795));
    println(getVertex(1,6940));
    println("#################");
    for(MLArray a : struct.getAllFields()){
      MLDouble list = (MLDouble) a;
      //println(Arrays.toString(list.getArray())); 
    }
  }
  
  double[][] getArray(int part){
    return ((MLDouble)struct.getField("vertexlist", part)).getArray(); 
  }
  
  int countVertices(int part){
    return ((MLDouble)struct.getField("vertexlist", part)).getArray().length;
  }
  
  double[] getVertex(int part, int index){
    return getArray(part)[index]; 
  }
  
}

class FaceList{
  MLStructure struct;
 
  FaceList() throws IOException{
    MatFileReader mfr = new MatFileReader(dataPath + "facelist.mat");
    struct = (MLStructure) mfr.getMLArray("F");
    println("#################");
    println(struct);
    println("#################");
    println(struct.contentToString());
    println("#################");
    println(struct.getField("facelist", 0));
    println("#################");
    println(countFaces(1));
    println(getVertex(1,1));
    println("#################");
   /* for(MLArray a : struct.getAllFields()){
      MLDouble list = (MLDouble) a;
      //println(Arrays.toString(list.getArray())); 
    }*/
  }
  
  double[][] getArray(int part){
    return ((MLDouble)struct.getField("facelist", part)).getArray(); 
  }
  
  int countFaces(int part){
    return ((MLDouble)struct.getField("facelist", part)).getArray().length;
  }
  
  double[] getVertex(int part, int index){
    return getArray(part)[index]; 
  }
  
}

