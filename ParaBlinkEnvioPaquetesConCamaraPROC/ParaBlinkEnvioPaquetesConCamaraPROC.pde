
//Libreiras de Serial y de Vídeo para Processing 2!!
import processing.video.*;
import processing.serial.*;

Capture cam;   //Variable de cámara
Serial myPort; //Variable de puerto serial

int brillo; //Variable para obtener el brillo por cada pixel utilizado
int[] intens; //Array que guarda el dato de cada pixel para enviar
int array_intens=0;  //Variable para establecer qué caja del array intens

int trama_longitud = 64; //Número total de datos enviados, trama(cada uno de los píxeles)
int inicio_de_trama = 255; //Número para establecer el principio del envío de la trama

int numero_de_vueltas=0;
void setup() {
  size(720, 720);
  noStroke(); 
  
  //Para ver cuantas cámaras están funcionando.
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  }else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
    //  println(cameras[i]);
    }
    
    // Seleccionamos qué cámara utilizamos
    cam = new Capture(this, cameras[0]);
    cam.start(); //Se inicializa la cámara
  }
  
  intens = new int[trama_longitud]; //Determinamos de cuanto va a ser el array
    
  String portName = Serial.list()[1]; //Seleccionamos el puerto Serial
  myPort = new Serial(this, portName, 9600); //Inicializamos.
  delay(1000); //Espera para que conecte con Arduino Mega.
}

void draw() {
  //Leemos cámara
  if (cam.available() == true) {
    cam.read();
  }
  //la visualizamos
  image(cam, -280, 0, 1280, 720); //Para imagen de 720x720
  
  //Mandamos el inicio de la trama
  myPort.write(inicio_de_trama);
  
  //Aquí leemos píxeles de la cámara que coinciden
  //con la matriz de 8x8.
  for(int i=50; i<700; i=i+90){ //pixeles en X
    for(int j=670; j>20; j=j-90){  //píxeles en Y
      color c = get(i, j);  //Leemos el color RGB del pixel
      brillo =int(brightness(c)); //Lo convertimos a número entero determinando su brillo
      
      //Como en este programa solo pasamos 0 y 1,
      //convertimos en brillo en encendido o apagado
      //a partir de una determinada intensidad de brillo.
      intens[array_intens]=brillo;
      if(intens[array_intens]<180){
        intens[array_intens]=1; //Y si el pixel de la cámara es oscuro, enciende el de la matriz.
      }else{
        intens[array_intens]=0; //Si tiene más brillo lo apaga (transforma los oscuros en luminosos)
      }
      myPort.write(intens[array_intens]); //Envia 0 o 1 por el puerto Serial
      //print(intens[array_intens]); //Lo imprime en consola
      array_intens++;  //Incrementa el array para la siguiente vuelta.
      if(array_intens>63){array_intens=0;}  //Si pasa de 63 lo vuelve a 0.
    }
  }
  //print(" - ");
  //println(numero_de_vueltas++);
  //delay(20);
  
  //background(150); //Si queremos poner la pantalla en negro.
  
  
}


