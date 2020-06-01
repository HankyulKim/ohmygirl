PImage mapImage;

Table dataTable;
Table locationTable;
Table nameTable;
TableRow row;
int rowCount;
float [] top; 
float [] low;
int [] order;
int [] order2;
int cnt1=0;
int cnt2=0;

float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

void setup() {
  size(640, 400);
  mapImage = loadImage("map.png");
  locationTable = loadTable("locations.tsv", "header");
  nameTable = loadTable("names.tsv", "header");
  dataTable = loadTable("value.tsv", "header");
  rowCount = locationTable.getRowCount();
  
  top = new float [rowCount];
  order = new int [rowCount];
  low = new float [rowCount];
  order2 = new int [rowCount];
  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if (value > dataMax) dataMax = value;
    if (value < dataMin) dataMin = value;
    top[row]=value;
    order[row]=row; 
    low[row]=value;
    order2[row]=row;
  }
  noStroke();
}

void draw() {
  background(255);
  image(mapImage, 0, 0);

  for (int i = 0; i < rowCount; i++) {
    String abbrev = dataTable.getRow(i).getString("abbrev");
    float value = dataTable.getRow(i).getFloat("value"); 
    row = locationTable.findRow(abbrev, "abbrev");
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    row = nameTable.findRow(abbrev, "abbrev");
    String name = row.getString("name");
    int check=0;
    if(cnt1==1){
      for(int j=0;j<10;j++){
        if(i==order[j]){
          drawData(name, x, y, value,cnt1,cnt2);
          check=1;
        }
      }
    }
    if(cnt2==1){
      for(int j=0;j<10;j++){
        if(i==order2[j]){
          drawData(name, x, y, value,cnt1,cnt2);
          check=1;
        }
      }
    }
    if(check==0)
      drawData(name, x, y, value,0,0);
  }
}

void drawData(String name, float x, float y, float value,int k1,int k2) {
  if(k1==0&&k2==0){
    
    float radius;
    if (value >= 0) {
      radius = map(value, 0, dataMax, 1.5, 15);
      fill(#333399);
    }
    else {
      radius = map(value, 0, dataMin, 1.5, 15);
      fill(#ec5166);
    }
    ellipseMode(RADIUS);
    ellipse(x, y, radius, radius);
  
    float d = dist(x, y, mouseX, mouseY);
    if (d < radius + 2) {
      textAlign(CENTER);
      text(name + " " + value, x, y-radius-4);
      ellipse(x, y, radius*1.3, radius*1.3);
    }
  }
  if(k1==1){
    float radius = map(value, 0, dataMax, 1.5, 15);
    fill(#333366);
    ellipse(x, y, radius*1.5, radius*1.5);
    float d = dist(x, y, mouseX, mouseY);
    if (d < radius + 2) {
      textAlign(CENTER);
      text(name + " " + value, x, y-radius-8);
      ellipse(x, y, radius*1.65, radius*1.65);
    }
  }
  if(k2==1){
    float radius = map(value, 0, dataMin, 1.5, 15);
    fill(#e61632);
    ellipse(x, y, radius*1.5, radius*1.5);
    float d = dist(x, y, mouseX, mouseY);
    if (d < radius + 2) {
      textAlign(CENTER);
      text(name + " " + value, x, y-radius-8);
      ellipse(x, y, radius*1.65, radius*1.65);
    }
  }
}

void keyPressed(){
  if(key==' '){
    valuechange();
    cnt1=0;
    cnt2=0;
  }
  if(key=='t'){
    cnt1=(cnt1+1)%2;
    cnt2=0;
    topvalue();
    
  }
  if(key=='l'){
    cnt2=(cnt2+1)%2;
    cnt1=0;
    lowvalue();
    
  }
  if(key=='r'){
    reverse();
    cnt1=0;
    cnt2=0;
  }
}

void topvalue(){
  for(int i=0;i<rowCount;i++){
    for(int j=0;j<i;j++){
      if(top[i]>top[j]){
        float temp=top[j];
        top[j]=top[i];
        top[i]=temp;
        int tmp;
        tmp=order[j];
        order[j]=order[i];
        order[i]=tmp;
      }
    }
  }

  
}
void lowvalue(){
  for(int i=0;i<rowCount;i++){
    for(int j=0;j<i;j++){
      if(low[i]<low[j]){
        float temp=low[j];
        low[j]=low[i];
        low[i]=temp;
        int tmp;
        tmp=order2[j];
        order2[j]=order2[i];
        order2[i]=tmp;
      }
    }
  }

  
}


void valuechange(){  
  for(int i=0;i<rowCount;i++) {
    float newValue=random(dataMin, dataMax);
    dataTable.setFloat(i,1,newValue);
    top[i]=newValue;
    order[i]=i; 
    low[i]=newValue;
    order2[i]=i;
  }
}

void reverse(){
  for(int i=0;i<rowCount;i++) {
    float Value=dataTable.getRow(i).getFloat("value"); 
    float reverseValue=0;
    if(Value>=0){
      reverseValue=dataMax-Value;
    }
    if(Value<0){
      reverseValue=dataMin-Value;
    }
    dataTable.setFloat(i,1,reverseValue);
    top[i]=reverseValue;
    order[i]=i; 
    low[i]=reverseValue;
    order2[i]=i;
  }
}
