import processing.serial.*;

Serial myPort;

int a=0;

int trama_longitud = 64;
int inicio_de_trama = 255;

void setup() {
  size(200, 200);
  noStroke();  
    
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  delay(5000);
}

void draw() {
  
  
  
  myPort.write(inicio_de_trama);
  println(inicio_de_trama);
  for(int i=0; i<64; i++){
    a=int(random(0,2));
    myPort.write(a);
    print(a);
    delay(5);
    a++;
  }
  a=0;
  
  //background(150);
  
  
}
