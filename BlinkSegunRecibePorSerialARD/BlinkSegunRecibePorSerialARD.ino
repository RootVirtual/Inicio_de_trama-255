
int nuevo_byte;

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
}
void loop() {
  while(Serial.available()==0){
    /* esperar */
  }

  nuevo_byte = Serial.read();
  
  digitalWrite(LED_BUILTIN, nuevo_byte);
  delay(200);
}
