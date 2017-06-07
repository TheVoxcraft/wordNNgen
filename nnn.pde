int word_len = 8;
int alphabet_size = 27;

char[] alphabet = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m',' '};

int charTof(char l){
  char[] alphabet = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m',' '};
  int letter = -1;
  for(int i=0; i<alphabet_size; i++){
    if(l == alphabet[i]){
      letter = i;
    }
  }
  return letter;
}

float[] StringTof(String rword){
  String word = rword.toLowerCase();
  float[] ff = new float[word_len*alphabet_size];
  for(int i=0; i<word.length()-1; i++){
    for(int j=0; j<alphabet_size; j++){
      float l = charTof(word.charAt(i));
      if(l == j){
        ff[j+(i*alphabet_size)] = 1.0;
      } else {
        ff[j+(i*alphabet_size)] = 0.0;
      }
    }
  }
  return ff;
}

float[] getRandom(){
  float[] ff = new float[word_len*alphabet_size];
  for(int i = 0; i < word_len*alphabet_size; i++){
     ff[i] = random(0,1);
  }
  return ff;
}

float[] normalizeOutput(float[] out){
    float[] nOut = new float[out.length];
    for(int i=0; i < out.length; i++){
      if(out[i] > .5){
        nOut[i] = 1;
      } else {
        nOut[i] = 0;
      }
    }
    return nOut;
  }

char fToChar(float[] c){
  char a = ' ';
  for(int i = 0;i<c.length; i++){
    if(c[i] == 1){
      a = alphabet[i];
    }
  }
  return a;
}

String fToString(float[] f){
  String word = "";
  float[] buffer = new float[alphabet_size];
  for(int i=0;i<word_len;i++){
    for(int j=0;j<alphabet_size;j++){
      buffer[j] = f[j+(alphabet_size*i)];
    }
    word += fToChar(buffer);
  }
  return word;
}

Network[] order(){
  Network[] newNN = new Network[nn.length/2];
  int[] sc = new int[nn.length];
  for(int i=0;i<nn.length;i++){
    sc[i] = nn[i].SCORE;
  }
  for(int i=0;i<nn.length;i++){
    sc[i] = nn[i].SCORE;
  }
  max(sc);
  return newNN;
}

Network[] eliminate(){
  Network[] newNN = new Network[nn.length/2];
  for(int i=0;i<nn.length/2;i++){
    newNN[i] = nn[i];
  }
  return newNN;
}

IntList ids = new IntList();

Network[] reproduce(){
  Network[] newNN = new Network[nn.length];
  
  for(int i=0;i<nn.length/2;i++){
    newNN[i] = getBest(nn);
  }
  
  for(int i=nn.length/2;i<nn.length;i++){
    newNN[i] = nn[i-nn.length/2].Reproduce();
  }
  return newNN;
}

Network getBest(Network[] x){
  int score = -1;
  
  Network bestNet = x[(int)random(0,nn.length)];
  for(int i=0;i<x.length;i++){
    for(int j=0;j<ids.size();j++){
      if((x[i].SCORE > score) && (ids.get(j) != bestNet.ID)){
        score = nn[i].SCORE;
        bestNet = x[i];
        ids.append(bestNet.ID);
      }
    }
  }
  return bestNet;
}

float error = 1;
String bestAns = "        ";
int gens = 1;

int pop = 500;
Network[] nn = new Network[pop];

void setup(){
  randomSeed(0);
  size(250,150);
  for(int i = 0; i<nn.length; i++){
    nn[i] = new Network();
  }
  //thread("geneticNet");
}

void draw(){
  background(67);
  text("Population: "+pop,10,15);
  text("Gen: "+gens,10,30);
  text("Avg Error: "+error,10,45);
  text("Best Answer: "+bestAns,10,60);
  
  geneticNet();
  bestAns = fToString(normalizeOutput(getBest(nn).run(getRandom())));
}

void getAvgError(){
  int x = 0;
  for(int j = 0; j<pop; j++){
    x+=(nn[j].SCORE/216);
  }
  error = x/pop;
  print(x);
}

void geneticNet(){ // WORK HERE <-- scoring and reproduction
  String[] data = loadStrings("names.txt");
  for(int k = 0; k < 1 ; k++){
    for(int j = 0; j<pop; j++){
      if(data[k].length() < 8){
        float[] input = getRandom();
        nn[j].updateScore(StringTof(data[k]));
      }
    }
  }
  gens++;
  getAvgError();
}