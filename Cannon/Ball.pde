class Ball {
  float xPos, yPos, rad, xSpeed, ySpeed;
  float xBullet, yBullet, positionX;
  float dir;
  color clr;

  Ball(float x, float y, float r, float xS, float yS, float red, float blue, float green) {
    xPos = x;
    yPos = y;
    rad = r;
    xSpeed = xS;
    ySpeed = yS;
    xBullet = width/2;
    yBullet = height;
    positionX = xBullet;
    dir = 1;
    clr=color(red, blue,green);
  }

  void display1() {
    fill(clr);
    ellipse(xPos, yPos, rad, rad);
  }
  
  void display2() {
    fill(clr);
    rect(xPos, yPos, rad, rad);
  }
  
  void display3(){
    fill(clr);
    ellipse(xPos, yPos, rad, rad*2);
  }

  void moveBall() {
    xPos += xSpeed*dir;
    yPos += ySpeed*dir;
  }

  void borders() {
    if (xPos > width-(rad/2) || xPos < 50) {
      dir *= -1;
    }
    if (yPos > height/2-100 || yPos < 50) {
      dir *= -1;
    }
  }

  void bullet(float k) {
    fill(#FF0000);
    float xBullet =k;
    positionX = xBullet;
    ellipse(positionX, yBullet, 20, 20);
    yBullet -= 3;
  }
  
  void repeat() {
    if (yBullet < -1000) {
      yBullet = height;

    }
  }

  boolean hit(Ball b) {
    float distance = dist(xPos, yPos, b.positionX, b.yBullet);
    if (distance < (rad/2)+10) {
      return true;
    } 
    else {
      return false;
    }
  }
}
