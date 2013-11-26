
class BrainPart {
  int partId;
  int sx, sy, sz; // pocatek casti (prvni roviny, ve kterych cast je)
  int ex, ey, ez; // konec casti (prvni roviny, ve kterych cast uz neni)
  boolean submask[][][];
  Position pos;
  

  BrainPart(int partId, Mask mask, RepreNodes repreNodes){
    this.partId = partId; 
    analyzeMask(mask);
    submask = new boolean[ex - sx][ey - sy][ez - sz];
    fillSubmask(mask);
    pos = repreNodes.get(partId-1);
  }

  private void analyzeMask(Mask mask){
    sx = mask.w;
    sy = mask.h;
    sz = mask.d;
    ex = 0;
    ey = 0;
    ez = 0;

    for(int x=0; x < mask.w; x++){
      for(int y=0; y < mask.h; y++){
        for(int z=0; z < mask.d; z++){
          if((int) mask.get(x,y,z) == partId){
            if(x < sx) sx = x;
            if(y < sy) sy = y;
            if(z < sz) sz = z;
            if(x > ex) ex = x;
            if(y > ey) ey = y;
            if(z > ez) ez = z;
          }
        }
      }
    }
    ex++;
    ey++;
    ez++;
  }

  private void fillSubmask(Mask mask){
    for(int x=sx; x < ex; x++){
      for(int y=sy; y < ey; y++){
        for(int z=sz; z < ez; z++){
          submask[x-sx][y-sy][z-sz] = mask.get(x,y,z) == partId;
        }
      }
    }
  }

  void draw(){
    print("drawing part " + partId + "( " + sx + " - " + ex + ", " + sy + " - " + ey + ", "+ sz + " - " + ez + " ) ...");
    pushMatrix();
    translate(sy -1, sx -1, sz -1);
    for(int x=sx; x < ex; x++){
      translate(1, 0, 0);
      for(int y=sy; y < ey; y++){
        translate(0, 1, 0);
        for(int z=sz; z < ez; z++){
          translate(0, 0, -1);
          if(submask[x-sx][y-sy][z-sz]){
            fill(partId, 90, 90, 30);
            box(1);
          }
        }
        translate(0, 0, ez-sz);
      }
      translate(0, sy-ey, 0);
    }
    popMatrix();
    println(" OK");
  }
}
