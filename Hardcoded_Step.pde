import java.util.*;
import java.math.BigInteger;
int ngen = 0;
//boolean evolve = false;
int fotonum = 0;
void setup() {
  size(2400, 800);
  setupbt();
  setupno();
  resettreebts();
  setupnl();
  setupql();
  setupro();
  setuptr();
  setuppop();
  origleafs = resetorigleafs(thenlist);
  //println(thenlist.get(0).nleafs);
}
void draw() {
  background(255);
  drawbt();
  drawnl();
  drawql();
  drawno();
  drawro();
  //drawtr();
  //println(nodeText);

   if (bState[0]) draw1(p.pop.length-1);
  // if (evolve) drawpop();
  drawbestn(10);
  //draw1only(p.pop.length-1);
  
  if (bState[0]) for (int i=0; i<100; i++) { 
    evolvepop();
    ngen++;
  }
  //println(nodeText);
}
void mousePressed() {
  pressbt();
  pressnl();
  pressql();
  pressno();
}
void keyPressed() {
  typenl();
  typeql();
  if (key=='e') bState[0] =!bState[0];
  if (key=='/') setuppop();
  if (key=='s') swapselnodes();
  if (key=='r') randomswap();
  if (key=='u') selectinternal();
  if (key=='l') swap(); 
  if (key=='z') for (int i=0; i<thenlist.size(); i++) print(thenlist.get(i).code);
  if (key=='y') {
    saveFrame("f"+fotonum+".jpg"); 
   fotonum++; 
  }
}

void mouseWheel(MouseEvent event) {
  if (event.getCount()==+1) scrollno(true);
  if (event.getCount()==-1) scrollno(false);
}