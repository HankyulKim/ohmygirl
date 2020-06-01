int thick1=1;
int thick2=1;
int r=1;
int g=1;
int b=1;
int eraser=0;

void setup(){
  size(800, 800);
  background(255);
}

void draw(){
  if(mousePressed){
    line(pmouseX, pmouseY, mouseX, mouseY); 
  }
  
  if(keyCode==UP&&thick1<50){ 
    thick1++;
    strokeWeight(thick1);
  }                                          
  if(keyCode==DOWN&&thick1>1){ 
    thick1--;
    strokeWeight(thick1);
  }                                    
  if(keyCode==RIGHT&&thick2<50){ 
    thick2++;
    strokeWeight(thick2);
  }                                          
  if(keyCode==LEFT&&thick2>1){ 
    thick2--;
    strokeWeight(thick2);
  }                                    
  keyCode = 0;                              
                       


  if(key=='1'&&r<255){        
    r++;
  }
  if(key=='2'&&g<255){
    g++;
  }
  if(key=='3'&&b<255){
    b++;
  }                                          
  if(key=='q'&&r>1){
    r--;
  }
  if(key=='w'&&g>1){
    g--;
  }
  if(key=='e'&&b>1){
    b--;
  }                                          
  key=0;                                                          
  if(eraser==1){
    strokeWeight(thick2);
    stroke(255, 255, 255);
  } 
  else{
    strokeWeight(thick1);
    stroke(r,g,b);
  }                                          

  print("thick_line : ");
  print(thick1);
  print(" thick_eraser : ");
  print(thick2);
  print(" R : ");
  print(r);
  print(", G : ");
  print(g);
  print(", B : ");
  print(b);
  print(" eraser : ");
  println(eraser);                           
}

void keyPressed(){
  if(key==' '){
    if(eraser == 0){
      eraser = 1;
    } 
    else{
      eraser = 0;
    }
  }                                          
}
