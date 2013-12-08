
class BrainPart {
  int partId;
  IMesh mesh;
  Position pos;
  
  ISphere rn;

  BrainPart(int partId, IMesh mesh, RepreNodes repreNodes){
    this.partId = partId; 
    this.mesh = mesh;
    pos = repreNodes.get(partId-1);
  }
  
  void genRepreNode(){
    rn = new ISphere(pos.x, pos.y, pos.z, 3).hsb(((double)(partId-1))/90.0, 0.7, 0.4, 0.8);
  }
  
  void onClicked(){
    mesh.hsb(((double)(partId-1))/90.0, 0.7, 0.4, 0.8);
  }
  
  IVecI getRepreNodeCenter(){
    return rn.center; 
  }

}


static class Connectivity{
  BrainPart p1, p2;
  ICurve edge;
 
  Connectivity(BrainPart p1, BrainPart p2){
    this.p1 = p1;
    this.p2 = p2;
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
    edge = new ICurve(p1.getRepreNodeCenter(), p2.getRepreNodeCenter());
    edge.clr(0.7, 0.1, 0.1, 0.7);
  }
}
