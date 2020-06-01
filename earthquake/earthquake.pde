PImage mapImage;
String[] earthquakes;


int clat = 0;
int clon = 0;
int ww = 1024;
int hh = 512;
int zoom = 1;

float mercX(float lon) {
  lon = radians(lon);
  float a = (256 / PI) * pow(2, zoom);
  float b = lon + PI;
  return a * b;
}

float mercY(float lat) {
  lat = radians(lat);
  float a = (256 / PI) * pow(2, zoom);
  float b = tan(PI / 4 + lat / 2);
  float c = PI - log(b);
  return a * c;
}


void setup() {
  size(1024, 512);

  
  String url = "https://api.mapbox.com/styles/v1/mapbox/streets-v9/static/0,0,1/1024x512"+"?access_token=pk.eyJ1IjoibmV3bm5ld2VyIiwiYSI6ImNqMDFwNGtmMTA0dGUzMmxqNG03cmdndjMifQ.SCRLymkJjgT6CDYYawR8zA";
  mapImage = loadImage(url, "jpg");
  
  translate(width/2, height/2);
  imageMode(CENTER);
  image(mapImage, 0, 0);

  earthquakes = loadStrings("all_month.csv");
  
  float cx = mercX(clon);
  float cy = mercY(clat);
  //ellipse(mercX(126.978)-cx, mercY(37.566)-cy, 10,10);//seoul

  for (int i = 1; i < earthquakes.length; i++) {
    String[] data = earthquakes[i].split(",");
    float lat = float(data[1]);
    float lon = float(data[2]);
    float mag = float(data[4]);
    float x = mercX(lon)-512;
    float y = mercY(lat)-512;
    mag = sqrt(pow(10, mag));
    float magmax = sqrt(pow(10, 10));
    float d = map(mag, 0, magmax, 0, 640);
    stroke(255, 0, 255);
    fill(255, 0, 255, 100);
    ellipse(x, y, d, d);
  }
}
