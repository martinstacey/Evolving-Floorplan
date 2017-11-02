ArrayList <Node> origleafs = new ArrayList<Node> ();

ArrayList <Node> resetorigleafs(ArrayList <Node> inlist) {
 ArrayList <Node> outn= new ArrayList ();
  for (int i=0; i<inlist.size(); i++) outn.add(new Node(inlist.get(i).code, inlist.get(i).atributes, inlist.get(i).loc));
  for (int i=0; i<inlist.size(); i++) if (inlist.get(i).leaf) {    
    outn.get(i).leaf=true;
    outn.get(i).leafnum=inlist.get(i).leafnum;
  }
  return outn;
}
ArrayList <Node>  permutate(ArrayList <Node> inlist,ArrayList <Node> origlist, int num) {
  ArrayList <String> oLeafs = new ArrayList <String> ();
  for (int i=0; i<origlist.size(); i++) if (origlist.get(i).leaf) oLeafs.add(inlist.get(i).leafnum+"");
  ArrayList <String> nLeafsn  = showpermutation(oLeafs, num);   
  ArrayList <String> code = new ArrayList<String>();  
  ArrayList <String> name = new ArrayList<String>();
  ArrayList <FloatList> idealq = new ArrayList<FloatList>();
  ArrayList <Node> outlist = inlist;

  for (int i=0; i<nLeafsn.size(); i++) for (int j=0; j<origlist.size(); j++) if (origlist.get(j).leaf) if (origlist.get(j).leafnum == int(nLeafsn.get(i))) code.add(origlist.get(j).code);
  for (int i=0; i<nLeafsn.size(); i++) for (int j=0; j<origlist.size(); j++) if (origlist.get(j).leaf) if (origlist.get(j).leafnum == int(nLeafsn.get(i))) name.add(origlist.get(j).name);
  for (int i=0; i<nLeafsn.size(); i++) for (int j=0; j<origlist.size(); j++) if (origlist.get(j).leaf) if (origlist.get(j).leafnum == int(nLeafsn.get(i))) idealq.add(origlist.get(j).idealqualities);

  for (int i=0; i<nLeafsn.size(); i++)  for (int j=0; j<thenlist.size(); j++) if (thenlist.get(j).leaf) if (thenlist.get(j).leafnum == i) outlist.get(j).code = code.get(i); 
  for (int i=0; i<nLeafsn.size(); i++)  for (int j=0; j<thenlist.size(); j++) if (thenlist.get(j).leaf) if (thenlist.get(j).leafnum == i) outlist.get(j).name = name.get(i);
  for (int i=0; i<nLeafsn.size(); i++)  for (int j=0; j<thenlist.size(); j++) if (thenlist.get(j).leaf) if (thenlist.get(j).leafnum == i) outlist.get(j).idealqualities = idealq.get(i);
  //print (code);
  //println();
  return outlist;
}
ArrayList <String> showpermutation(ArrayList <String> _elements, int permnum) {
  int[] indices;
  ArrayList <String> elements = _elements;
  PermutationGenerator x = new PermutationGenerator (elements.size());
  ArrayList <String> permutation;
  ArrayList <String> showp=new ArrayList<String>();
  for ( int j=0; j<factint(elements.size()); j++) {
    permutation = new ArrayList <String> ();
    indices = x.getNext ();
    for (int i = 0; i < indices.length; i++) permutation.add (elements.get(indices[i]));
    if (j==permnum) showp=permutation;
  }
  return showp;
}
class PermutationGenerator {                                             //class obtained from processing forum
  int[] a;
  BigInteger numLeft;
  BigInteger total;
  PermutationGenerator (int n) {
    if (n < 1) throw new IllegalArgumentException ("Min 1");
    a = new int[n];
    total = fact (n);
    for (int i = 0; i < a.length; i++)  a[i] = i;                   // Reset
    numLeft = new BigInteger (total.toString ());
  }
  BigInteger getNumLeft () {               // Return number of permutations not yet generated
    return numLeft;
  } 
  BigInteger getTotal () {     // Return total number of permutations
    return total;
  } 
  boolean hasMore () {                                     // Are there more permutations?
    return numLeft.compareTo (BigInteger.ZERO) == 1;
  }  
  int[] getNext () {                        // Generate next permutation (algorithm from Rosen p. 284)
    if (numLeft.equals (total)) {
      numLeft = numLeft.subtract (BigInteger.ONE);
      return a;
    }
    int temp;                             // Find largest index j with a[j] < a[j+1]
    int j = a.length - 2;
    while (a[j] > a[j+1])  j--;
    int k = a.length - 1;               // Find index k such that a[k] is smallest integer
    while (a[j] > a[k]) k--;           // greater than a[j] to the right of a[j] 
    temp = a[k];                      // Interchange a[j] and a[k]
    a[k] = a[j];
    a[j] = temp; 
    int r = a.length - 1;                 // Put tail end of permutation after jth position in increasing order
    int s = j + 1; 
    while (r > s) {
      temp = a[s];
      a[s] = a[r];
      a[r] = temp;
      r--;
      s++;
    } 
    numLeft = numLeft.subtract (BigInteger.ONE);
    return a;
  }
} 