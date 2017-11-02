ArrayList <Node> swapno(ArrayList <Node> tree1_, ArrayList <Node> tree2_ ) {                     //ArrayList <Node> setupnodetree(ArrayList <Node> _nodelist, PVector _inpos, PVector _trsize) {      setupnodehouse(ArrayList <Node> _nodelist, PVector _houseinsize) {
  ArrayList <Node> n = new ArrayList<Node>();
  ArrayList <Node> tree1  = new ArrayList <Node> ();
  ArrayList <Node> tree2 = new ArrayList <Node> ();
  for (int i=0; i<tree1_.size(); i++) tree1.add(new Node(tree1_.get(i).code, tree1_.get(i).atributes, tree1_.get(i).loc ));
  for (int i=0; i<tree2_.size(); i++) tree2.add(new Node(tree2_.get(i).code, tree2_.get(i).atributes, tree2_.get(i).loc ));
  for (int i=0; i<tree1_.size(); i++) if (tree1_.get(i).fatherselect) tree1.get(i).fatherselect=true;
  for (int i=0; i<tree1_.size(); i++) if (tree1_.get(i).select) tree1.get(i).select=true;
  for (int i=0; i<tree2_.size(); i++) if (tree2_.get(i).fatherselect) tree2.get(i).fatherselect=true;
  for (int i=0; i<tree2_.size(); i++) if (tree2_.get(i).select) tree2.get(i).select=true;
  String fathert1 = "";
  String fathert2 = "";
  for (int i=0; i<tree1.size(); i++) if (tree1.get(i).fatherselect) fathert1=tree1.get(i).loc;
  for (int i=0; i<tree2.size(); i++) if (tree2.get(i).fatherselect) fathert2=tree2.get(i).loc;
  for (int i=0; i<tree1.size(); i++) if (!tree1.get(i).select) n.add(tree1.get(i));      
  for (int i=0; i<tree2.size(); i++) if (tree2.get(i).select) {
    tree2.get(i).loc = tree2.get(i).loc.substring(fathert2.length());
    tree2.get(i).loc = fathert1+tree2.get(i).loc;
    n.add(tree2.get(i));
  }
  Collections.sort(n);
  n = setupnodehouse(setupnodetree(n, nlistpos, nlistsize), houseSize);
  return n;
}
ArrayList <Node> randomsw (ArrayList <Node> tree1_, ArrayList <Node> tree2_ ) { 
  ArrayList <Node> n = new ArrayList<Node>();
  ArrayList <Node> tree1  = new ArrayList <Node> ();
  ArrayList <Node> tree2 = new ArrayList <Node> ();
  for (int i=0; i<tree1_.size(); i++) tree1.add(new Node(tree1_.get(i).code, tree1_.get(i).atributes, tree1_.get(i).loc ));
  for (int i=0; i<tree2_.size(); i++) tree2.add(new Node(tree2_.get(i).code, tree2_.get(i).atributes, tree2_.get(i).loc ));
  int ran1;
  String ran1loc;
  ran1 = int(random(tree1.size())); 
  while (tree1.get(ran1).gen>tree2_.get(0).ngen) ran1 = int(random(tree1.size()));
  tree1.get(ran1).fatherselect=true;
  ran1loc=tree1.get(ran1).loc;
  for (int i=0; i<tree1.size(); i++) if (tree1.get(i).loc.length()>=ran1loc.length()) if (ran1loc.equals(tree1.get(i).loc.substring(0, ran1loc.length()))) tree1.get(i).select = true;
  int ran2;
  String ran2loc;
  ran2 = int(random(tree2.size())); 
  while (tree1.get(ran1).gen!=tree2.get(ran2).gen) ran2 = int(random(tree2.size()));
  tree2.get(ran2).fatherselect=true;
  ran2loc=tree2.get(ran2).loc;
  for (int i=0; i<tree2.size(); i++) if (tree2.get(i).loc.length()>=ran2loc.length()) if (ran2loc.equals(tree2.get(i).loc.substring(0, ran2loc.length()))) tree2.get(i).select = true;

  String fathert1 = "";
  String fathert2 = "";
  for (int i=0; i<tree1.size(); i++) if (tree1.get(i).fatherselect) fathert1=tree1.get(i).loc;
  for (int i=0; i<tree2.size(); i++) if (tree2.get(i).fatherselect) fathert2=tree2.get(i).loc;
  for (int i=0; i<tree1.size(); i++) if (!tree1.get(i).select) n.add(tree1.get(i));      
  for (int i=0; i<tree2.size(); i++) if (tree2.get(i).select) {
    tree2.get(i).loc = tree2.get(i).loc.substring(fathert2.length());
    tree2.get(i).loc = fathert1+tree2.get(i).loc;
    n.add(tree2.get(i));
  }
  Collections.sort(n); 
  n = setupnodehouse(setupnodetree(n, nlistpos, nlistsize), houseSize);
  return n;
}
ArrayList <Node> selectinternal(ArrayList <Node> _tree) {
  ArrayList <Node> n = new ArrayList<Node>();  
  ArrayList <Node> tree  = new ArrayList <Node> ();
  for (int i=0; i<_tree.size(); i++) tree.add(new Node(_tree.get(i).code, _tree.get(i).atributes, _tree.get(i).loc ));
  for (int i=0; i<tree.size(); i++) tree.get(i).room=true;
  for (int i=0; i<tree.size(); i++) for (int j=0; j<tree.size(); j++) if (tree.get(i).loc.length()<tree.get(j).loc.length()) if (tree.get(i).loc.equals(tree.get(j).loc.substring(0,tree.get(i).loc.length()))) tree.get(i).room=false;
  
  int ran1;
  String ran1loc;
  ran1 = int(random(1, tree.size()));     
  while (tree.get(ran1).room) ran1 = int(random(1,tree.size()));           
  tree.get(ran1).fatherselect=true;
  ran1loc=tree.get(ran1).loc;        
  for (int i=0; i<tree.size(); i++) if (tree.get(i).loc.length()>=ran1loc.length()) if (ran1loc.equals(tree.get(i).loc.substring(0, ran1loc.length()))) tree.get(i).select = true; 
  int ran2;
  String ran2loc;  
  ran2 = int(random(1, tree.size())); 
  while (tree.get(ran1).gen!=tree.get(ran2).gen||tree.get(ran2).room) ran2 = int(random(tree.size()));
  tree.get(ran2).motherselect=true;
  ran2loc=tree.get(ran2).loc;
  for (int i=0; i<tree.size(); i++) if (tree.get(i).loc.length()>=ran2loc.length()) if (ran2loc.equals(tree.get(i).loc.substring(0, ran2loc.length()))) tree.get(i).mselect = true;
  n=tree;
  n = setupnodehouse(setupnodetree(n, nlistpos, nlistsize), houseSize);
  return n;
}
ArrayList <Node> sawpinternal(ArrayList <Node> _tree) {
  ArrayList <Node> n = new ArrayList<Node>();      
  ArrayList <Node> tree  = new ArrayList <Node> ();
  for (int i=0; i<_tree.size(); i++) tree.add(new Node(_tree.get(i).code, _tree.get(i).atributes, _tree.get(i).loc ));
  for (int i=0; i<_tree.size(); i++) if (_tree.get(i).fatherselect) tree.get(i).fatherselect = true;
  for (int i=0; i<_tree.size(); i++) if (_tree.get(i).motherselect) tree.get(i).motherselect = true;
  for (int i=0; i<_tree.size(); i++) if (_tree.get(i).select)  tree.get(i).select  = true;
  for (int i=0; i<_tree.size(); i++) if (_tree.get(i).mselect) tree.get(i).mselect = true;
  String fatherloc = "";
  String motherloc = ""; 
  for (int i=0; i<tree.size(); i++) if (tree.get(i).fatherselect) fatherloc = tree.get(i).loc;      
  for (int i=0; i<tree.size(); i++) if (tree.get(i).motherselect) motherloc = tree.get(i).loc;  
  for (int i=0; i<tree.size(); i++) if (tree.get(i).fatherselect) tree.get(i).loc= motherloc;
  for (int i=0; i<tree.size(); i++)  if (tree.get(i).select) {
    tree.get(i).loc = tree.get(i).loc.substring(fatherloc.length());
    tree.get(i).loc = motherloc+tree.get(i).loc;
  }
  for (int i=0; i<tree.size(); i++) if (tree.get(i).motherselect) tree.get(i).loc=fatherloc ;
  for (int i=0; i<tree.size(); i++)  if (tree.get(i).mselect) {
    tree.get(i).loc = tree.get(i).loc.substring(motherloc.length());
    tree.get(i).loc = fatherloc+tree.get(i).loc;
  }
  n=tree;
  Collections.sort(n); 
  n = setupnodehouse(setupnodetree(n, nlistpos, nlistsize), houseSize);
  return n;
}