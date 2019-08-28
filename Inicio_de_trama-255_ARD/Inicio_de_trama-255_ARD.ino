/*
Envio datos desde Processing a Arduino para encender
una matriz de LEDs de 8x8

PROCESING ENVÍA 0 Y 1, para el true/false de encendido/apagado de cada led

      Matriz8x8     Arduino
          |           |
         Gnd ------- Gnd
         Vcc ------- 5v
         DIN ------- 12
         CLK ------- 11
         CS -------- 10
         
 */

//Libreria para la matriz led
#include "LedControlMS.h"

//Variables:
//Cantidad total de leds 8x8

int trama_longitud = 64;
int inicio_de_trama = 255;
int trama_array[64];
int nuevo_byte;
int indice_lectura = 0;

int a=0;

//Pines para el modulo de la matriz
LedControl lc=LedControl(12,11,10,1);

void setup() {
  Serial.begin(9600);

  
  //Cosas de la librería:
  lc.shutdown(0,false);//Reiniciarla
  lc.setIntensity(0,8);//Decirle la intensidad de luz (0-15);
  lc.clearDisplay(0);//Apagar todo
  
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
}

void loop() {

  while(Serial.available()==0){
    /* esperar */
  }

  nuevo_byte = Serial.read();
  if (nuevo_byte == inicio_de_trama) {
    indice_lectura = 0;

    for(int k=7;k>=0;k--){
      for(int j=0;j<8;j++){
        lc.setLed(0,k,j,trama_array[a]);
        a++;
      }
    }
    a=0;
    
    
  }else{
    if (indice_lectura < trama_longitud) {
      trama_array[indice_lectura++] = nuevo_byte;
    }else{
      /* Error de la muerte, nunca deberia de pasar */
    }
  }

}
