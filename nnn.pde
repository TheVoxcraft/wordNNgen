int word_len = 8;
int alphabet_size = 27;

int charTof(char l){
  char[] alphabet = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m',' '};
  int letter = -1;
  for(int i=0; i<27; i++){
    if(l == alphabet[i]){
      letter = i;
    }
  }
  return letter;
}

float[] StringTof(String word){
  float[] ff = new float[216];
  for(int i=0; i<word.length(); i++){
    for(int j=0; j<27; j++){
      float l = charTof(word.charAt(i));
      if(l == j){
        ff[j+(i*27)] = 1.0;
      } else {
        ff[j+(i*27)] = 0.0;
      }
    }
  }
  return ff;
}

float[] getRandom(){
  float[] ff = new float[217];
  for(int i = 0; i < 217; i++){
     ff[i] = random(0,1);
  }
  return ff;
}

char fToChar(float[] c){
  char[] alphabet = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m',' '};
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
  float[] buffer = new float[27];
  for(int i=0;i<8;i++){
    for(int j=0;j<27;j++){
      buffer[j] = f[j+(27*i)];
    }
    word += fToChar(buffer);
  }
  return word;
}

int pop = 20;
int runs = 1;
Network[] nn = new Network[pop];

void setup(){
  
  
  String[] data = loadStrings("names.txt");
  
  //for(int i = 0; i<runs; i++){
  //  for(String word : data){
  //    for(int j = 0; j<pop; j++){
  //      float[] input = StringTof(word);
  //      //nn[j].run(input);
  //    }
  //  }
  //}
  //float[] f = StringTof("qwuh");
  //for(int i=0;i<216)
  //for(int i=0;i<27;i++){
  //  print(fToChar(x));
  //}
}


String getBestAns(){
  float score = -1;
  Network bestNet;
  for(int i=0;i<pop;i++){
    if(nn[i].SCORE > score){
      score = nn[i].SCORE;
      bestNet = nn[i];
    }
  }
  return fToString(bestNet.run(getRandom()));
}