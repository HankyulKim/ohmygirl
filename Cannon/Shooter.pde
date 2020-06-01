class Shooter {
  float xPos, yPos, xRad, yRad;
  float xBarrel, yBarrel;
  float rot;

  Shooter () {
    xPos = width;
    yPos = height-25;
    xRad = 100;
    yRad = 88;
    xBarrel = 80;
    yBarrel = 250;
    rot = 0;
  }

  void displayCannon(float k) {
    pushMatrix();
    rectMode(CENTER);
    fill(100);
    rect(k, yPos, xBarrel, yBarrel); 
    fill(#FF0000);
    rect(k, yPos-150, 5, 20); 
    fill(70);
    rect(k, yPos-125, xRad, yRad-50);
    fill(130);
    ellipse(k, yPos, 100, 50);
    fill(180);
    rect(width/2, height, width*2, 50); 
    fill(#CC9900);
    rect(k+50, yPos-10, 25, 60);
    rect(k-50, yPos-10, 25, 60);
    
    popMatrix();
  }
}
