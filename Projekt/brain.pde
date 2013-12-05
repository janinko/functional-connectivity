
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
