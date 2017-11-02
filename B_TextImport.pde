Nodeqlist nl;

String nTextSize = "10x9";
PVector t0pos= new PVector(30, 35*3);
PVector t1pos=new PVector (30, 35*6);
PVector t2pos=new PVector (30, 35*9);

void setupnl() {
  nl = new Nodeqlist ();
}
void drawnl() {
  nl.display();
}
void pressnl() {
  nl.press();
}
void typenl() {
  nl.type();
}
class Nodeqlist {
  PVector insize;
  ArrayList <Textedit> te = new ArrayList <Textedit>();
  Nodeqlist() {
    insize = new PVector(200, 15);  
    te.add(new Textedit(t0pos, insize, nodeText, "Input Rooms No Structure", 13));
    te.add(new Textedit(t1pos, insize, nodeText, "Input Rooms As Tree Structure", 13));
    te.add(new Textedit(t2pos, insize, nTextSize, "Terrain Dimensions", 13));
  }
  void display() {
    for (Textedit t : te) t.display();
  }
  void press() {
    if (te.get(0).isover()) if (te.get(0).select) {
      nodeText = te.get(0).gettextfromnodes();
      thenlist=te.get(0).textnodesnostructure(); 
      resettreebts();
      origleafs =resetorigleafs(thenlist);
    }
    if (te.get(1).isover()) if (te.get(1).select) {
      nodeText = te.get(1).gettext();
      thenlist=te.get(1).textnodes();
      resettreebts();
      origleafs = resetorigleafs(thenlist);
    }
    if (te.get(2).isover()) if (te.get(2).select) te.get(2).textodim();
    for (Textedit t : te) if (t.isover()) t.select=!t.select;
    for (Textedit t : te) if (t.isover()) qu = new QualitiesList (thenlist, t3pos);
  }
  void type() {
    for (Textedit t : te)  t.type();
  }
}
class Textedit {
  PVector pos, size, halfsize, poscenter, dim;
  String text, tittle;
  String dash = "|";
  boolean select;
  int textsize;
  Textedit(PVector _pos, PVector _size, String _intext, String _tittle, int _textsize) {
    pos=_pos;
    size=_size;
    text=_intext;
    tittle = _tittle;
    halfsize = PVector.mult(size, .5);
    poscenter = PVector.add(pos, halfsize);
    textsize = _textsize;
  }
  void display() {
    rectMode(CORNER);
    if (select) fill(230);
    else fill(255);
    stroke(200);
    rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    textAlign(CORNER, CENTER);
    textSize(13);
    text(tittle, pos.x, pos.y-10);
    if (text.length()<50) {
      if (select) text(text+dash, pos.x+5, poscenter.y);
      else text(text, pos.x+5, poscenter.y);
    }
  }
  boolean isover() {
    if (mouseX>poscenter.x-halfsize.x&&mouseX<poscenter.x+halfsize.x&&mouseY>poscenter.y-halfsize.y&&mouseY<poscenter.y+halfsize.y) return true;
    else return false;
  }
  void select() {
    if (isover()) select = !select;
  }
  String gettext() {
    return text;
  }
  String gettextfromnodes(){
    String newtext= treestr(text);
    return newtext;
  }
  ArrayList <Node> textnodesnostructure() {
    ArrayList <Node> nodefromtx = new ArrayList<Node>();      
    if (!nodeText.equals("")) nodefromtx=setupnodehouse(setupnodetree(Nodesfromstring(treestr(text)), nlistpos, nlistsize), houseSize);
    return nodefromtx;
  }
  ArrayList <Node>  textnodes() {
    ArrayList <Node> nodefromtx = new ArrayList<Node>();
    if (!nodeText.equals("")) nodefromtx=setupnodehouse(setupnodetree(Nodesfromstring(text), nlistpos, nlistsize), houseSize);
    return nodefromtx;
  }
  ArrayList <Node>  textodim() {
    ArrayList <Node> nodefromtx= new ArrayList<Node>();
    houseSize =   dimension(text);
    if (!nodeText.equals("")) thenlist=setupnodehouse(setupnodetree(Nodesfromstring(nodeText), nlistpos, nlistsize), houseSize);
    return nodefromtx;
  }
  void type() {
    if (select) {
      if ((key >= 'A' && key <= 'z') ||(key >= '0' && key <= '9') || key == ' '|| key=='('|| key==')'|| key==','|| key=='.'|| key=='|')  text = text + key;
      if (key==BACKSPACE ) if (text.length()>0) text = text.substring(0, text.length()-1);
    }
  }
}
class textrect {
  PVector pos, size;
  String text;
  int i;
  textrect(PVector _pos, PVector _size, String _text, int _i) {
    pos=_pos;
    size=_size;
    text=_text;
    i=_i;
  }
  void display() {
    fill(255);
    textAlign(CENTER, CENTER);
    rect(pos.x, pos.y, size.x, size.y);
    fill(100);
    if (text!=null) text(text, pos.x + size.x*.5, pos.y + size.y*.5);
  }
}