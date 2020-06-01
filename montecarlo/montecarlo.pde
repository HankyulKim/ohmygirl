int w, h, cw, ch;
float x, y, pi;
int inCircle, outCircle;
int speed=1;
int play=1;
int cnt=0,cnt2=0;
float[] list=new float[100000];
float[] piexpand=new float[100000];
float[] picompress=new float[100000];
int check=0;

int pin() {
  x = random(-1, 1);
  y = random(-1, 1);
  double dist = sqrt(x*x+y*y);
  if (dist<=1) {
    inCircle++;
    fill(0, 0, 255);
    ellipse((int)(x*(w/2)), (int)(y*(h/2)), 3, 3);
    return 1;
  } 
  else {
    outCircle++;
    fill(127);
    ellipse((int)(x*(w/2)), (int)(y*(h/2)), 3, 3);
    return 0;
  }
}

void drawGraph() {
  fill(0);
  noStroke();
  pi = 4 * (float)inCircle / (inCircle+outCircle);
  list[cnt2]=pi;
  stroke(255,0,0);
  if(cnt2<=1070){
    fill(255);
    rectMode(CORNER);
    stroke(0);
    rect(580,0,1800,700);
    stroke(0);
    fill(0);
    text(piexpand[check],590,560);
    text("3.141",590,300);
    text(picompress[check],590,40);
    line(630,40,1700,40);
    line(630,300,1700,300);
    line(630,560,1700,560);
    stroke(255,0,0);
    float c=300;
    for(int i=0;i<=cnt2;i++){
      float k=map(list[i],piexpand[check],picompress[check],560,40);
      line(629+i,c,630+i,k);
      c=k;
    }
  }
  else{
    fill(255);
    rectMode(CORNER);
    noStroke();
    rect(580,0,1800,600);
    stroke(0);
    fill(0);
    text(piexpand[check], 590, 560);
    text("3.141", 590, 300);
    text(picompress[check], 590, 40);
    line(630,40,1700,40);
    line(630,300,1700,300);
    line(630,560,1700,560);
    stroke(255,0,0);
    float d=0;
    for(int i=0 ; i<1070 ; i++){
      float k= map(list[i+cnt2-1070], piexpand[check], picompress[check], 560, 40);
      line(629+i,d,630+i,k);
      d=k;
    }
  }
  cnt2++;
}

void setup() {
  w = h = 500;
  cw = ch = 300;
  piexpand[0]=2.141;
  piexpand[1]=3;
  piexpand[2]=3.137;
  picompress[0]=4.141;
  picompress[1]=3.28;
  picompress[2]=3.146;
  
  size(1800, 600);
  randomSeed(0);
  background(255);
  rectMode(CENTER);
  rect(cw, ch, w, h);
  frameRate(150);
}

void draw() {
  noStroke();
  if(play==1){
    translate(cw, ch);
    for(int i=1;i<=speed;i++)
    {
      pin();
    }
    translate(-cw,-ch);
    if(cnt%speed==0){
      drawGraph();
    }
    cnt++;
  }
  
}

void keyPressed(){
  if(keyCode==UP){
    if(speed<20)
      speed++;
  }
  if(keyCode==DOWN){
    if(speed>1)
      speed--;
  }
  if(key==' '){
    play=(play+1)%2;
  }
  if(key=='z'){
    if(check<2)
      check++;
  }
  if(key=='x'){
    if(check>0)
      check--;
  }
}
