

class Transform{
  VertexList vl;
  FaceList fl;
  Callback cb = null;
  
  Transform(VertexList vl, FaceList fl){
    this.vl = vl;
    this.fl = fl;
  }
  
  void setCallback(Callback cb){
    this.cb = cb;
  }
  
  IMesh toMesh(int part){
    double[][] datav = vl.getArray(part);
    double[][] dataf = fl.getArray(part);
    IVertex[] vertices = new IVertex[datav.length];
    for(int i=0; i < datav.length; i++){
      if(cb != null && i % 100 == 0) cb.visit(0.5 * i / datav.length);
      vertices[i] = new IVertex(datav[i][0], datav[i][1], datav[i][2]);
    }
    IFace[] faces = new IFace[dataf.length];
    int min=9999999;
    for(int i=0; i < dataf.length; i++){
      if(cb != null && i % 100 == 0) cb.visit(0.5 * i / datav.length + 0.5);
      int v1 = (int)dataf[i][0];
      int v2 = (int)dataf[i][1];
      int v3 = (int)dataf[i][2];
      faces[i] = new IFace(vertices[v1-1], vertices[v2-1], vertices[v3-1]);
    }
    return new IMesh(faces);
  }
  
}

interface Callback{
  void visit(float perc);
}

class LogCallback implements Callback{
  float last=-1;
  float diff=0.1;
  
  void visit(float perc){
    if(perc > last + diff){
      println(perc + " %");
    }
  }
}
