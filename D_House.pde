ArrayList <Room> rlist;
PVector housepos = new PVector (1400, 50);

ArrayList <Room> rlist2;
PVector housepos2 = new PVector (1400, 450);

void setupro() {
  rlist= new ArrayList <Room> (); 
  rlist2= new ArrayList <Room> ();
}
void drawro() {
  if (!bState[0]) {
    rlist= new ArrayList <Room> ();  
    for (int i=0; i<thenlist.size(); i++) if (thenlist.get(i).room) rlist.add(new Room(thenlist.get(i), nlistscale, housepos));
  }
  for (int i=0; i<rlist.size(); i++)  rlist.get(i).display();
  for (int i=0; i<rlist.size(); i++)  rlist.get(i).displayadj();
  //for (int i=0; i<rlist.size(); i++)  rlist.get(i).displayqu();

  if (!bState[0]) {
    rlist2= new ArrayList <Room> ();  
    for (int i=0; i<thenlist2.size(); i++) if (thenlist2.get(i).room) rlist2.add(new Room(thenlist2.get(i), nlistscale2, housepos2));
  }
  //for (int i=0; i<rlist2.size(); i++)  rlist2.get(i).display();
  //for (int i=0; i<rlist2.size(); i++)  rlist2.get(i).displayadj();
 // for (int i=0; i<rlist2.size(); i++)  rlist2.get(i).displayqu();
}
class Room {
  Node no;
  float scale;
  PVector postrans, possc, sizesc, posscmid;
  ArrayList <PVector> adjpos;
  Room(Node _no, float _scale, PVector _postrans) {
    no=_no;
    scale = _scale;
    postrans=_postrans;
    possc = new PVector(no.gpos.x*scale+postrans.x, no.gpos.y*scale+postrans.y);
    sizesc = new PVector(no.gsize.x*scale, no.gsize.y*scale);
    posscmid = new PVector (possc.x+(sizesc.x*.5), possc.y+(sizesc.y*.5));  
    adjpos =  new ArrayList<PVector>();
    for (int i=0; i<no.adjacent.size(); i++) adjpos.add(new PVector ( (no.gpos.x+(no.gsize.x*.5))*scale+postrans.x, (no.gpos.y+(no.gsize.y*.5))*scale+postrans.y))   ;
  }
  void display() {
    rectMode(CORNER);
    colorMode(HSB, 1.0, 1.0, 1.0, 1.0);
    if (no.select) fill(no.clr, 1, 1, 1);    
    else fill(no.clr, 1, 1, 0.1); 
    rect(possc.x, possc.y, sizesc.x, sizesc.y);
    colorMode(RGB, 255, 255, 255);
    pushMatrix();
    if (no.gsize.x<1.0) {
      translate(posscmid.x, posscmid.y);
      rotate(-PI/2);
      translate(-posscmid.x, -posscmid.y);
    }  
    fill(0);
    textSize(10);
    if (no.name!=null) text(no.name, posscmid.x, posscmid.y);    
    text(nf(no.gsize.x, 0, 2)+"x"+nf(no.gsize.y, 0, 2), posscmid.x, posscmid.y+10);
    popMatrix();
  }
  void displayadj() { 
    colorMode(RGB, 255, 255, 255);
    stroke(200);
    fill(0);
    for (int j=0; j<no.adjacent.size(); j++) {       
      text(no.adjacent.get(j).code, +possc.x+10, possc.y+10*j+10);
      float x2 = ((no.adjacent.get(j).gpos.x+(no.adjacent.get(j).gsize.x*.5))*scale)+postrans.x;
      float y2 = ((no.adjacent.get(j).gpos.y+(no.adjacent.get(j).gsize.y*.5))*scale)+postrans.y; 
      line (posscmid.x, posscmid.y, x2, y2);
    }
  }
  void displayqu() {
    textAlign(CORNER, CENTER);
    textSize(8);
    for (int i=0; i<no.qualities.size(); i++)  text("q: "+  nf(no.qualities.get(i), 0, 0)+"  iq: "+  nf(no.idealqualities.get(i), 0, 0)+" w:"+no.qualitiesweight.get(i) , posscmid.x-50, posscmid.y+20+(10*i));    
    text("q:", posscmid.x-50, posscmid.y+60);
    for (int i=0; i<no.adjacent.size(); i++)  text(no.adjacent.get(i).code, posscmid.x-40+i*15, posscmid.y+60); 
    text("iq:", posscmid.x-50, posscmid.y+70);
    for (int i=0; i<no.idealadjacent.size(); i++) text(no.idealadjacent.get(i), posscmid.x-40+i*15, posscmid.y+70); 
    text("adjf: "+nf(no.fitadj, 0, 0)+ "W:" + no.idealadjw.get(0), posscmid.x-50, posscmid.y+80);    
    text("f: "+nf(no.fit, 0, 0), posscmid.x-50, posscmid.y+90);    
    text("totf: "+nf(no.totalfit, 0, 0), posscmid.x-50, posscmid.y+100);
  }
}