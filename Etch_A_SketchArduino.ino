int potArduino0;
int potArduino1;
int potArduino2;

boolean buttonRead = 0;

int inByte = 0;

void setup() {
  Serial.begin(9600);
  pinMode(A5,INPUT_PULLUP);
  establishContact();
}

void loop() {
  if(Serial.available() > 0){
    inByte = Serial.read();
    
    potArduino0 = analogRead(A0)/4;
    Serial.write(potArduino0);
    delay(10);

    potArduino1 = analogRead(A1)/4;
    Serial.write(potArduino1);
    delay(10);

    potArduino2 = analogRead(A2)/4;
    Serial.write(potArduino2);
    delay(10);

    //buttonRead = 255 * digitalRead(5);
    buttonRead = digitalRead(5);
    Serial.write(buttonRead);
    delay(10);
  }
}

void establishContact(){
  while(Serial.available() <= 0){
    Serial.println('A');
    delay(300);
  }
}

