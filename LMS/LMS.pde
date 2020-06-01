class Point
{
  float x;
  float y;
  float val;
  int num;
}
int cnt = 0;
float inCircle = 0, outCircle = 0;
float maxVal = 0.0, minVal = 400.0;
int speed = 1;
int len = 12000;
int freq = 100;
float buttonX = 135, buttonY = 465;
int clicked = 0;
int start = freq;
ArrayList<Point> points = new ArrayList<Point>();
int mode = 0;

void drawArrow(int x, int y, int dir)
{
  if(dir == 0)
  {
    pushMatrix();
    translate(x, y);
    triangle(0, -20, -10, -10, 10, -10);
    rect(-5, -10, 10, 20);
    popMatrix();
  }
  if(dir == 1)
  {
    pushMatrix();
    translate(x, y);
    triangle(0, 20, 10, 10, -10, 10);
    rect(-5, -10, 10, 20);
    popMatrix();
  }
}
void drawPoint(int cnt)
{
  noStroke();
  ellipseMode(CENTER);
  Point tPoint = new Point();
  tPoint.x = random(-1, 1);
  tPoint.y = random(-1, 1);
  tPoint.num = cnt;
  if(pow(tPoint.x, 2)+pow(tPoint.y, 2)<=1)
  {
    inCircle += 1;
    fill(#db706c);
  }
  else
  {
    outCircle += 1;
    fill(#567ace);
  }
  tPoint.val = inCircle*4/(inCircle + outCircle);
  points.add(tPoint);
  float tx = map(tPoint.x, -1, 1, 20, 380);
  float ty = map(tPoint.y, -1, 1, 20, 380);
  ellipse(tx, ty, 1, 1);
  if(points.size()%freq == 0)
  {
    drawGraph();
  }
}
void drawGraph()
{
  noStroke();
  fill(255);
  rect(390, 0, 1600, 500);
  stroke(0);
  strokeWeight(1);  
  line(400, 0, 400, 400);
  line(400, 400, 1600, 400);
  maxVal = 0.0;
  minVal = 400.0;
  if(mode == 0)
  {
    if(points.size()<=len)
    {
      for(int i=freq;i<=points.size();i+=freq)
      {
        maxVal = max(maxVal, points.get(i-1).val, PI);
        minVal = min(minVal, points.get(i-1).val, PI);
      }
      for(int i=freq*2;i<=points.size();i+=freq)
      {
        float tx = map(i, 0, len, 400, 1600);
        float ty = map(points.get(i-1).val, maxVal, minVal, 0, 400);
        float px = map(i-freq, 0, len, 400, 1600);
        float py = map(points.get(i-freq-1).val, maxVal, minVal, 0, 400);
        stroke(255, 0, 0);
        line(px, py, tx, ty);
      }
    }
    else
    {
      for(int i=points.size()-len;i<=points.size();i+=freq)
      {
        maxVal = max(maxVal, points.get(i-1).val, PI);
        minVal = min(minVal, points.get(i-1).val, PI);
      }
      for(int i=points.size()-len+freq;i<=points.size();i+=freq)
      {
        float tx = map(i, points.size()-len, points.size(), 400, 1600);
        float ty = map(points.get(i-1).val, maxVal, minVal, 0, 400);
        float px = map(i-freq, points.size()-len, points.size(), 400, 1600);
        float py = map(points.get(i-freq-1).val, maxVal, minVal, 0, 400);
        stroke(255, 0, 0);
        line(px, py, tx, ty);
      }
    }
  }
  if(mode == 1)
  {
    if(points.size()<=len)
    {
      for(int i=start;i<=points.size();i+=freq)
      {
        maxVal = max(maxVal, points.get(i-1).val, PI);
        minVal = min(minVal, points.get(i-1).val, PI);
      }
      for(int i=start+freq;i<=points.size();i+=freq)
      {
        float tx = map(i, 0, len, 400, 1600);
        float ty = map(points.get(i-1).val, maxVal, minVal, 0, 400);
        float px = map(i-freq, 0, len, 400, 1600);
        float py = map(points.get(i-freq-1).val, maxVal, minVal, 0, 400);
        stroke(255, 0, 0);
        line(px, py, tx, ty);
      }
    }
    else
    {
      for(int i=start;i<=points.size();i+=freq)
      {
        maxVal = max(maxVal, points.get(i-1).val, PI);
        minVal = min(minVal, points.get(i-1).val, PI);
      }
      for(int i=start+freq;i<=points.size();i+=freq)
      {
        float tx = map(i, 0, points.size(), 400, 1600);
        float ty = map(points.get(i-1).val, maxVal, minVal, 0, 400);
        float px = map(i-freq, 0, points.size(), 400, 1600);
        float py = map(points.get(i-freq-1).val, maxVal, minVal, 0, 400);
        stroke(255, 0, 0);
        line(px, py, tx, ty);
      }
    }
  }
  textAlign(LEFT, TOP);
  fill(0);
  textSize(20);
  text(nf(float("" + maxVal), 0, 7), 1670, 10);
  text(nf(float("" + minVal), 0, 7), 1670, 390);
  text(nf(float("" + "" + points.get(points.size()-1).val), 0, 7), 1670, 200);
  noStroke();
  fill(0, 0, 255);
  if(minVal<=PI && PI<=maxVal)
  {
    stroke(0, 0, 255);
    line(400, map(PI, maxVal, minVal, 0, 400), 1600, map(PI, maxVal, minVal, 0, 400));
    textAlign(CENTER, CENTER);
    textSize(20);
    text("PI", 1640, map(PI, maxVal, minVal, 0, 400));
  }
  if(PI>maxVal)
  {
    textAlign(CENTER, TOP);
    text("PI", 1640, 50);
    drawArrow(1640, 30, 0);
  }
  if(PI<minVal)
  {
    textAlign(CENTER, BOTTOM);
    text("PI", 1640, 350);
    drawArrow(1640, 370, 1);
  }
}
void drawMenu()
{
  fill(255);
  noStroke();
  rect(10, 390, 360, 50);
  fill(255);
  rect(10, 390, 100, 100);
  fill(200);
  rect(120, 440, 260, 50);
  stroke(0);
  line(135, 465, 365, 465);
  fill(255, 255, 255);
  if(clicked==1)
  {
    fill(255, 0, 0);
  }
  if(clicked==1)
  {
    buttonX = mouseX;
    if(buttonX < 135)
    {
      buttonX = 135;
    }
    if(buttonX > 365)
    {
      buttonX = 365;
    }
  }
  speed = int(map(buttonX, 135, 365, 1, 500));
  ellipse(buttonX, buttonY, 20, 20);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(20);
  text("dots: " + int(inCircle) + " / " + int(inCircle+outCircle), 20, 400);
  text("speed", 30, 454);
}
void setup()
{
  frameRate(300);
  size(1800, 500);
  noStroke();
  background(255);
}
void draw()
{
  fill(255);
  noStroke();
  for(int i=0;i<speed;i++)
  {
    cnt++;
    drawPoint(cnt);
  }
  drawMenu();
}

void mousePressed()
{
  if(mouseButton == LEFT)
  {
    if(dist(buttonX, 465, mouseX, mouseY)<10)
    {
      clicked = 1;
    }
  }
}

void mouseReleased()
{
  if(mouseButton == LEFT)
  {
    clicked = 0;
  }
}

void keyPressed()
{
  if(keyCode == ' ')
  {
    mode++;
    mode = mode % 2;
  }
  if(key == 'r')
  {
    points = new ArrayList<Point>();
  }
}
