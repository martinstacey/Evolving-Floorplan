ArrayList <Toproom> trlist;
PVector thousepos = new PVector (1600, 50);

ArrayList <Toproom> trlist2;
PVector thousepos2 = new PVector (1600, 450);

float tnlistscale = 70;
float tnlistscale2 = 70;
void setuptr() {
  trlist= new ArrayList <Toproom> (); 
  trlist2= new ArrayList <Toproom> ();
}
void drawtr() {
  if (!bState[0]) {
    trlist= new ArrayList <Toproom> ();  
    for (int i=0; i<thenlist.size(); i++) if (thenlist.get(i).room) trlist.add(new Toproom(thenlist.get(i), tnlistscale, thousepos));
  }
  for (int i=0; i<trlist.size(); i++)  trlist.get(i).display();
  for (int i=0; i<trlist.size(); i++)  trlist.get(i).displayadj();

  if (!bState[0]) {
    trlist2= new ArrayList <Toproom> ();  
    for (int i=0; i<thenlist2.size(); i++) if (thenlist2.get(i).room) trlist2.add(new Toproom(thenlist2.get(i), tnlistscale2, thousepos2));
  }
  for (int i=0; i<trlist2.size(); i++)  trlist2.get(i).display();
  for (int i=0; i<trlist2.size(); i++)  trlist2.get(i).displayadj();
}
class Toproom {
  Node no;
  float scale;
  PVector postrans, possc, sizesc, posscmid;
  ArrayList <PVector> adjpos;
  Toproom(Node _no, float _scale, PVector _postrans) {
    no=_no;
    scale = _scale;
    postrans=_postrans;
    possc = new PVector(no.tpos.x*scale+postrans.x, no.tpos.y*scale+postrans.y);
    sizesc = new PVector(no.tsize.x*scale, no.tsize.y*scale);
    posscmid = new PVector (possc.x+(sizesc.x*.5), possc.y+(sizesc.y*.5));  
    adjpos =  new ArrayList<PVector>();
    for (int i=0; i<no.tadjacent.size(); i++) adjpos.add(new PVector ( (no.tpos.x+(no.tsize.x*.5))*scale+postrans.x, (no.tpos.y+(no.tsize.y*.5))*scale+postrans.y))   ;
  }
  void display() {
    rectMode(CORNER);
    colorMode(HSB, 1.0, 1.0, 1.0, 1.0);
    if (no.select) fill(no.clr, 1, 1, 1);    
    else fill(no.clr, 1, 1, 0.1); 
    rect(possc.x, possc.y, sizesc.x, sizesc.y);
    colorMode(RGB, 255, 255, 255);
    pushMatrix();
    if (no.tsize.x<1.0) {
      translate(posscmid.x, posscmid.y);
      rotate(-PI/2);
      translate(-posscmid.x, -posscmid.y);
    }  
    fill(0);
    textSize(10);
    if (no.code!=null) text(no.code, posscmid.x, posscmid.y);    
    popMatrix();
  }
  void displayadj() { 
    colorMode(RGB, 255, 255, 255);
    stroke(200);
    fill(0);
    for (int j=0; j<no.tadjacent.size(); j++) {       
      text(no.tadjacent.get(j).code, +possc.x+10, possc.y+10*j+10);
      float x2 = ((no.tadjacent.get(j).tpos.x+(no.tadjacent.get(j).tsize.x*.5))*scale)+postrans.x;
      float y2 = ((no.tadjacent.get(j).tpos.y+(no.tadjacent.get(j).tsize.y*.5))*scale)+postrans.y; 
      line (posscmid.x, posscmid.y, x2, y2);
    }
  }
}