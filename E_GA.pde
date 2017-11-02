Population p;
Atribute [] at;

int nPopX= 25;
int nPopY = 25;
int popSize = nPopX*nPopY;

void setuppop() {
  ArrayList <Node> c;
  if (nodeText!="")  c=setupnodehouse(setupnodetree(Nodesfromstring(nodeText), nlistpos, nlistsize), houseSize);
  else c=setupnodehouse(setupnodetree(Nodesfromstring(hru[ButtonSl [0]]), nlistpos, nlistsize), houseSize);
  at = new Atribute [c.get(0).nroots*2+1];                                                                     //+1

  for (int i=0; i<c.get(0).nroots; i++)   at[i] = new Atribute ("Proportion", 0.1, 1); 
  for (int i=c.get(0).nroots; i<c.get(0).nroots*2; i++)   at[i] = new Atribute ("Swap", 0, 4); 
  at[c.get(0).nroots*2] = new Atribute ("sdc",1,factint((thenlist.size()/2)+1));
  p = new Population(popSize);
}
float fitnessat(float [] att) {
  float f=0;
  ArrayList <Node> c=thenlist;
  //do room assigment
  
  
  //Proportion
  for (int i=0; i<c.size(); i++) if (!c.get(i).room) c.get(i).atri.get(2).value = 0;  
  int attn=0;
  for (int i=0; i<c.size(); i++) if (!c.get(i).room) {    
    c.get(i).atri.get(1).value = att[attn];
    attn++;
  }
  //Swap
  for (int i=0; i<c.size(); i++) if (!c.get(i).room) {    
    c.get(i).atri.get(0).value = int(att[attn]);
    attn++;
  }
  //ArrayList <Node> origc = resetorigleafs(c);
 //c = permutate(c,origc,int(att[attn]));                                          //
  c =(setupnodehouse(c, houseSize));
  f -= c.get(0).totalfit;
  return f;
}
void draw1(int ind) {  
  fill(255, 0, 0); 
  if (bState[0]) {
    ArrayList <Node> c=thenlist; 
    for (int i=0; i<c.size(); i++) if (!c.get(i).room)  c.get(i).atri.get(2).value = 0;
    int attn=0;
    //Proportion
    for (int i=0; i<c.size(); i++) if (!c.get(i).room) {      
      c.get(i).atri.get(1).value  = p.pop[ind].phenos[attn];
      attn++;
    }
    //Swap
    for (int i=0; i<c.size(); i++) if (!c.get(i).room) {    
      c.get(i).atri.get(0).value = int(p.pop[ind].phenos[attn]);
      attn++;
    }
    c =(setupnodehouse(c, houseSize));
    thenlist = c;
    ArrayList <Room> d = new ArrayList<Room> ();
    for (int i=0; i<c.size(); i++) if (thenlist.get(i).room)  d.add(new Room (c.get(i), nlistscale, housepos));
    rlist = d;

    ArrayList <Toproom> e = new ArrayList<Toproom> ();
    for (int i=0; i<c.size(); i++) if (thenlist.get(i).room)  e.add(new Toproom (c.get(i), tnlistscale, thousepos));
    trlist = e;
    //ellipse(p.pop[ind].phenos[0]*width, height/2, 50, 50);
    //fill(0);
    //textSize(100);
    //text(abs(p.pop[ind].iFit), width/2, height/2);
  }
}
void draw1only(int ind) {
  ArrayList <Node> c=thenlist;  
  c.get(0).atri.get(1).value = p.pop[ind].phenos[0];    //neccesary?
  c.get(0).fatherselect=true;
  c =(setupnodehouse(c, houseSize));
  //for (int i=0; i<c.size(); i++) c.get(i).display();
}
void drawpop() {
  for (int i=0; i<p.pop.length; i++) {                                                       //Population Draw
    pushMatrix();
    scale(1.0/nPopX, 1.0/nPopY);
    translate(width*(i%nPopX), height*(i/nPopY));
    fill(255);
    rectMode(CORNER);
    rect(0, 0, width, height);
    draw1(i);
    popMatrix();
  }
}
void drawbestn(int numstart) {
  for (int i=p.pop.length-numstart; i<p.pop.length; i++) {                                                       //Population Draw
    pushMatrix();
    scale(1.0/nPopX, 1.0/nPopY);
    translate(width*(i%nPopX), height*(i/nPopY));
    fill(255);
    rectMode(CORNER);
    rect(0, 0, width, height);
    draw1(i);
    popMatrix();
  }
}
void evolvepop() {
  p.evolve();                                                                                 //Population Evolve (every 10 frameCounts)
}
class Atribute {
  String name;
  float min;
  float max;
  Atribute(String _name, float _min, float _max) {
    name=_name;
    min=_min;
    max=_max;
  }
}
class Population {
  Individual [] pop;
  int nPop;
  Population(int _nPop) {
    nPop = _nPop;
    pop = new Individual[nPop];
    for (int i=0; i<nPop; i++) {   
      pop[i] = new Individual(at);
      pop[i].evaluate();
    }
    Arrays.sort(pop);                                                                          //Arrays is a JAVA class identifier  //sort is one of its functions: it sorts a class of comparable elements
  }
  Individual select() {
    int which = (int)floor(((float)nPop-1e-6)*(1.0-sq(random(0, 1))));                          //skew distribution; multiplying by 99.999999 scales a number from 0-1 to 0-99, BUT NOT 100
    if (which == nPop) which = 0;
    return pop[which];                                                                         //the sqrt of a number between 0-1 has bigger possibilities of giving us a smaller number
  }                                                                                            //if we subtract that squares number from 1 the opposite is true-> we have bigger possibilities of having a larger number
  Individual sex(Individual a, Individual b) {
    Individual c = new Individual(at);
    for (int i=0; i<c.genes.length; i++) {
      if (random(0, 1)<0.5) c.genes[i] = a.genes[i];
      else c.genes[i] = b.genes[i];
    }
    c.mutate();
    c.inPhens();
    return c;
  }
  void evolve() {
    Individual a = select();
    Individual b = select();                                                                  //breed the two selected individuals    
    Individual x = sex(a, b);                                                                 //place the offspring in the lowest position in the population, thus replacing the previously weakest offspring    
    pop[0] = x;                                                                               //evaluate the new individual (grow)   
    x.evaluate();                                                                             //the fitter offspring will find its way in the population ranks   
    Arrays.sort(pop);
  }
  class Individual implements Comparable {                                                     //The Comparable Interface (JAVA) imposes a TOTAL ORDERING 
    float iFit;
    int [] genes;
    float [] phenos, phenosmin, phenosmax;
    Atribute[] a;
    Individual(Atribute [] _a) {
      a=_a;
      iFit = 0;
      genes  = new int [a.length];
      phenos = new float [genes.length];
      phenosmin = new float [phenos.length];
      phenosmax = new float [phenos.length];
      for (int i=0; i<phenosmin.length; i++) phenosmin [i] = a[i].min;
      for (int i=0; i<phenosmax.length; i++) phenosmax [i] = a[i].max;    
      for (int i=0; i<genes.length; i++) genes[i] = (int) random(256);
      for (int i=0; i<phenos.length; i++) phenos [i] = map(genes[i], 0, 256, phenosmin[i], phenosmax[i]);
    }
    void inGens() {
      genes = new int [a.length];
      for (int i=0; i<genes.length; i++) genes[i] = (int) random(256);
    }
    void inPhens() {
      for (int i=0; i<phenos.length; i++) phenos [i] = map(genes[i], 0, 256, phenosmin[i], phenosmax[i]);
    }
    void mutate() {                                                                               //5% mutation rate
      for (int i=0; i<genes.length; i++) if (random(100)<5)  genes[i] = (int) random(256);
    }
    void evaluate() {
      iFit = fitnessat(phenos);
    }
    int compareTo (Object objI) {                                                                 //method of the Comparable Interface
      Individual iToCompare = (Individual) objI;
      if (iFit<iToCompare.iFit) return -  1;                                                        //if i am less fit than iToCompare return -1
      else if (iFit>iToCompare.iFit)  return 1;                                                   //if i am fitter than iToCompare return 1
      return 0;                                                                                   //if we are equally fit return 0
    }
  }
}