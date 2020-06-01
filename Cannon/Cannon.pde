int numBalls = 10;
int catchBalls=0;
PFont myFont;
int xPos=0;

Ball[] balls = new Ball[numBalls];
Ball[] balls2 = new Ball[numBalls];
Ball[] balls3 = new Ball[numBalls];

int[] check1=new int[numBalls];
int[] check2=new int[numBalls];
int cnt=1;
Ball cannonBall;
Shooter cannon;
boolean shoot = false;

void setup() {
  size(500, 500);
  colorMode(HSB);
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball(random(50, 450), 60, random(25, 75), random(-10, 10), random(-10, 10),random(0, 255),random(0,255),random(0, 255));
  }
  for (int i=0; i<balls2.length; i++) {
    balls2[i] = new Ball(random(50, 450), 60, random(25, 75), random(-10, 10), random(-10, 10),random(0, 255),random(0,255),random(0, 255));
  }
  for (int i=0; i<balls3.length; i++) {
    balls3[i] = new Ball(random(50, 450), 60, random(25, 75), random(-10, 10), random(-10, 10),random(0, 255),random(0,255),random(0, 255));
  }
  cannon = new Shooter();
  cannonBall = new Ball(0, 0, 0, 0, 0, 0, 0, 0);
}

void draw() {
  background(255*cnt);
  noStroke();

  for (int i=0; i<balls.length; i++) {
    balls[i].display1();
    balls[i].moveBall();
    balls[i].borders();
    
  }
  for (int i=0; i<balls.length; i++) {
    if(check1[i]==1){
      balls2[i].display2();
      balls2[i].moveBall();
      balls2[i].borders();
    }
  }
  for (int i=0; i<balls.length; i++) {
    if(check2[i]==1){
      balls3[i].display3();
      balls3[i].moveBall();
      balls3[i].borders();
    }
  }
  
  if(key=='d'||key=='D'){
    xPos+=5;
    if(xPos>=640)
    {
      xPos=0;
      cnt=(cnt+1)%2;
    }
  }
  if(key=='a'||key=='A'){
    xPos-=5;
    if(xPos<=-40)
    {
      xPos=600;
      cnt=(cnt+1)%2;      
    }
  }
  key=0;
  for (int j=0; j<20; j++) {
    if (mousePressed) {
      shoot = true;
    }

    if (shoot == true) {
      cannonBall.bullet(xPos);
      cannonBall.repeat();
      if (mousePressed) {
        shoot = false;
      }
    }
  }

  for (int k=0; k<balls.length; k++) {
    if (balls[k].hit(cannonBall)) {
      balls[k].xPos = 100000;
      balls[k].yPos = 100000;
      catchBalls++;
      check1[k]=1;
    }
  }
  for (int k=0; k<balls2.length; k++) {
    if (balls2[k].hit(cannonBall)) {
      balls2[k].xPos = 100000;
      balls2[k].yPos = 100000;
      catchBalls++;
      check2[k]=1;
    }
  }
  for (int k=0; k<balls3.length; k++) {
    if (balls3[k].hit(cannonBall)) {
      balls3[k].xPos = 100000;
      balls3[k].yPos = 100000;
      catchBalls++;
    }
  }
  
  cannon.displayCannon(xPos);
  
  if(catchBalls==numBalls*3){
    myFont=createFont("Source Code Pro",32);
    textFont(myFont);
    textAlign(CENTER, CENTER);
    text("complete!",width/2,height/2);
  }
}
