import processing.serial.*;

Serial myPort;

int envio=0;

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
  for(int i=0; i<64; i++){
    envio=int(random(0,2));
    myPort.write(envio);
    println(envio);
    delay(5);
    envio++;
  }
  envio=0;
  //delay(20);
    
}
