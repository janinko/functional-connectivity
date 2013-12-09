
class BrainPart {
  int partId;
  Position pos;
  HashSet<Connectivity> connections = new HashSet<Connectivity>();
  String info;
  
  double hue;
  
  IMesh mesh;
  ISphere rn;

  BrainPart(int partId, IMesh mesh, RepreNodes repreNodes, BrainInfo bi){
    this.partId = partId; 
    hue = ((double)(partId-1))/90.0;
    pos = repreNodes.get(partId-1);
    info = bi.get(partId-1);
    this.mesh = mesh;
    mesh.hsb(hue, 0.7, 0.4, 0.1);
  }
  
  void genRepreNode(){
    rn = new ISphere(pos.x, pos.y, pos.z, 3).hsb(hue, 0.3, 0.3, 1);
  }
  
  void onClicked(){
    for(Connectivity conn : connections){
      conn.selected();
      conn.p1.mesh.hsb(conn.p1.hue, 0.7, 0.4, 0.6);
      conn.p2.mesh.hsb(conn.p2.hue, 0.7, 0.4, 0.6);
    }
    println("Clicked on: " + info);
    rn.hsb(hue, 0.9, 0.5, 1);
    mesh.hsb(hue, 0.7, 0.4, 0.9);
  }
  
  IVecI getRepreNodeCenter(){
    return rn.center; 
  }
  
  void deselected(){
    mesh.hsb(hue, 0.7, 0.4, 0.1);
    rn.hsb(hue, 0.3, 0.3, 1);
  }

}


static class Connectivity{
  BrainPart p1, p2;
  ICylinder edge;
 
  Connectivity(BrainPart p1, BrainPart p2){
    this.p1 = p1;
    this.p2 = p2;
    p1.connections.add(this);
    p2.connections.add(this);
  }
  
  static Set<Connectivity> generate(Adjectance adj, List<BrainPart> parts){
    HashSet<Connectivity> out = new HashSet<Connectivity>();
    for(int x = 0; x < 90; x++){
      for(int y = x+1; y < 90; y++){
        if(adj.get(x,y) > 0){
          out.add(new Connectivity(parts.get(x), parts.get(y))); 
        }
      }
    }
    return out;
  }
  
  void genEdge(){
    edge = new ICylinder(p1.getRepreNodeCenter(), p2.getRepreNodeCenter(), 0.8);
    edge.hsb(0, 0.0, 0.2, 0.3);
  }
  
  void selected(){
    edge.hsb(1, 0.8, 1, 1);
  }
  
  void deselected(){
    edge.hsb(0, 0.0, 0.2, 0.3);
  }
}
