boolean [] bState = {false};
int ButtonSl [] = {29, 39,0,0}; 
ArrayList <ButtonSlider> m = new ArrayList< ButtonSlider> ();
ArrayList<Button> bt  = new ArrayList<Button>(); 
void setupbt() {
  m.add( new ButtonSlider(40, 220, 0, hru.length-1, 35*7, 15, "Premade Tree:1"));
  m.add( new ButtonSlider(40, 220, 0, hru.length-1, 35*8, 15, "Premade Tree:2"));
  m.add( new ButtonSlider(40, 220, 0, hru.length-1, 35*4, 15, "Tree No"));
  m.add( new ButtonSlider(40, 220, 0, hru.length-1, 35*5, 15, "Room Assigment"));
  bt.add(new Button(40, 30*19, 20, "Evolve", bState[0]));
}
void resettreebts(){
  
  int cnum =catalanint((thenlist.size()/2)) ;
  int fnum = factint((thenlist.size()/2)+1);
 m.set(2,new ButtonSlider(40, 220, 0, cnum-1, 35*4, 15, "Tree No" + " ("+cnum+")"));
 m.set(3,new ButtonSlider(40, 220, 0,  fnum-1, 35*5, 15, "Room Assig"+" ("+fnum+")"));
}
void drawbt() {
  for (int i=0; i<m.size(); i++) m.get(i).display(ButtonSl[i]);
  for (int i=0; i<m.size(); i++) ButtonSl[i]=m.get(i).value;
  for (Button b : bt)    b.display();
  for (int i=0; i<bt.size(); i++)  bState[i]=bt.get(i).state;
}
void pressbt() {
  for (int i=0; i<m.size(); i++) m.get(i).press();
  for (int i=0; i<m.size(); i++) ButtonSl[i] = m.get(i).value;
  for (Button b : bt)   b.press();
  for (int i=0; i<bt.size(); i++) bState[i] = bt.get(i).state; 
  if (m.get(0).clickdown()||m.get(0).clickup()) {
    nodeText = hru[ButtonSl [0]];    
    thenlist = setupnodehouse(setupnodetree(Nodesfromstring(nodeText), nlistpos, nlistsize), houseSize);
    setupql();
    setuppop();
    resettreebts();
    origleafs = resetorigleafs(thenlist);
  }
  if (m.get(1).clickdown()||m.get(1).clickup()) {
    nodeText2 = hru[ButtonSl [1]];    
    thenlist2 = setupnodehouse(setupnodetree(Nodesfromstring(nodeText2), nlistpos2, nlistsize2), houseSize2);
  }
   if (m.get(3).clickdown()||m.get(3).clickup()){
     thenlist = permutate(thenlist, origleafs, ButtonSl[3]);
   }
}
class ButtonSlider {
  int x, x2, y, bSize;
  String label;
  boolean state1, state2;
  int value;
  float min, max;
  float fc1;
  float fc2;
  ButtonSlider(int _x, int _x2, float _min, float _max, int _y, int _bSize, String _label) {
    x = _x;
    x2=_x2;
    y = _y;
    min=_min;
    max=_max;
    bSize = _bSize;
    label = _label;
  }
  void display(int _value) {
    strokeWeight(1);
    value = _value;
    pushStyle();
    textSize(13);
    colorMode(RGB, 255);
    textSize(13);
    stroke(200);
    textAlign(CENTER, CENTER);
    stroke(200);
    fill(255);
    if (state1) fill(230);
    else  fill(255);
    line( x+(bSize/4), y-(bSize/4), x-(bSize/4), y);
    line( x+(bSize/4), y+(bSize/4), x-(bSize/4), y);
    ellipse(x, y, bSize, bSize);
    if (state2) fill(230);
    else  fill(255);
    line(x2-(bSize/4), y-(bSize/4), x2+(bSize/4), y);
    line(x2-(bSize/4), y+(bSize/4), x2+(bSize/4), y);
    ellipse(x2, y, bSize, bSize);
    fill(100);
    textAlign(LEFT, CENTER);
    text(label, x+bSize, y-2);
    textAlign(RIGHT, CENTER);
    text(value, x2-bSize, y-2);
    popStyle();
    if (frameCount==fc1+10)state1=false;
    if (frameCount==fc2+10)state2=false;
  }
  boolean clickdown() {
    if (mouseX > (x - bSize/2.0) && mouseX < (x + bSize/2.0)  &&mouseY > (y - bSize/2.0) && mouseY < (y + bSize/2.0))  return true;
    else return false;
  }
  boolean clickup() {
    if (mouseX > (x2 - bSize/2.0) && mouseX < (x2 + bSize/2.0)  &&mouseY > (y - bSize/2.0) && mouseY < (y + bSize/2.0)) return true;
    else return false;
  }
  void press() {
    if (clickdown()) {   
      state1=true;
      fc1 = frameCount;
      if (value>min) value--;
    }
    if (clickup()) {
      state2=true;
      fc2 = frameCount;
      if(value<max)value++;
    }
  }
}


class Button {
  int x, y, bSize;
  String label;
  boolean state;
  Button(int _x, int _y, int _bSize, String _label, boolean _state) {
    x = _x;
    y = _y;
    bSize = _bSize;
    label = _label;
    state = _state;
  }
  void display() {
    pushStyle();
    colorMode(RGB, 255);
    textSize(13);
    stroke(200);
    textAlign(CENTER, CENTER);
    if (state) {
      stroke(200);
      fill(255);
      fill(230);
      ellipse(x, y, bSize, bSize);
    } else {
      fill(255);
      //fill(100);
      ellipse(x, y, bSize, bSize);
    } 
    fill(100);
    textAlign(LEFT, CENTER);
    text(label, x+bSize, y);
    popStyle();
  }
  boolean isover() {
    if (mouseX > (x - bSize/2) && mouseX < (x + bSize/2)  &&mouseY > (y - bSize/2) && mouseY < (y + bSize/2)) return true;
    else return false;
  }
  void press() {
    if (isover()) state = !state;
  }
}