class Network{
  
  int in_size = (alphabet_size*word_len)+1; // get:board-pos, get:health, get:food, get:memory, bias
  int l1_size = 70+1; // + 1 bias
  int l2_size = 70+1; // + 1 bias
  int out_size = 216; // vector:direction, bool:move, bool:eat, out:memory
  
  float[] in = new float[in_size];
  float[] l1 = new float[l1_size];
  float[] l2 = new float[l2_size];
  float[] out = new float[out_size];
  
  float[][] in_l1 = new float[in_size][l1_size];
  float[][] l1_l2 = new float[l1_size][l2_size];
  float[][] l2_out = new float[l2_size][out_size];
  
  float muationRate = .05; // ADD THIS LATER!
  
  float SCORE = 0;
  
  void randomizeWeights(){
    for(int i=0; i < in_size; i++){
      for(int j=0; j < l1_size; j++){
        in_l1[i][j] = random(-1.0, 1.0);
      }
    }
    for(int i=0; i < l1_size; i++){
      for(int j=0; j < l2_size; j++){
        l1_l2[i][j] = random(-1.0, 1.0);
      }
    }
    for(int i=0; i < l2_size; i++){
      for(int j=0; j < out_size; j++){
        l2_out[i][j] = random(-1.0, 1.0);
      }
    }
  }
  
  void setBias(){
  in[in_size-1] = 1;
  l1[l1_size-1] = 1;
  l2[l2_size-1] = 1;
  }
  
  float[] run(float[] inputs){
    // Insert inputs
    for(int i=0; i < in_size-1; i++){
      in[i] = inputs[i];
    }
    
    // Feed forward
    for(int i=0; i < in_size-1; i++){
      for(int j=0; j < l1_size-1; j++){
        l1[j] += in[i]*in_l1[i][j];
      }
    }
    for(int i=0; i < l1_size-1; i++){
      l1[i] = activation(l1[i]);
      for(int j=0; j < l2_size-1; j++){
        l2[j] += l1[i]*l1_l2[i][j];
      }
      
    }
    for(int i=0; i < l2_size-1; i++){
      l2[i] = activation(l2[i]);
      for(int j=0; j < out_size; j++){
        out[j] += l2[i]*l2_out[i][j];
      }
    }
    
    for(int j=0; j < out_size; j++){
        out[j] = sigmoid(out[j]);
    }
    
    return out;
  }
  
  Network Reproduce(Network partner){
    Network child = new Network();
    
    for(int i=0; i < in_size-1; i++){
      for(int j=0; j < l1_size-1; j++){
        if(random(0.0, 1.0) <= muationRate){
          child.in_l1[i][j] = random(-1.0, 1.0); //print("m");
        }
      }
    }
    for(int i=0; i < l1_size-1; i++){
      for(int j=0; j < l2_size-1; j++){
        if(random(0.0, 1.0) <= muationRate){
          child.l1_l2[i][j] += random(-1.0, 1.0);//print("m");
        }
      }
    }
    for(int i=0; i < l2_size-1; i++){
      for(int j=0; j < out_size; j++){
        if(random(0.0, 1.0) <= muationRate){
          child.l2_out[i][j] = random(-1.0, 1.0);//print("m");
        }
      }
    }
    
    return child;
  }
  
  float tanh(float x){
    return (float)Math.tanh(x);
  }
  
  float activation(float x){
    return tanh(x);
  }
  
  float RELU(){
    return 1;
  }
  
  float sigmoid(float x){
   return 1/(1+pow(2.71828182846,-x));
  }
  Network(){
    randomizeWeights();
    setBias();
  }
}