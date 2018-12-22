import processing.serial.*;
Serial myPort;
int[] serialArray = new int[4];
int serialCount = 2;
int xpos;
int ypos;
int colorChange;
boolean buttonRead = true;
boolean firstContact = false;

void setup() {
  size(256, 256);
  background(255, 0, 0);
  rectMode(CENTER);
  fill(200);
  noStroke();
  rect(width/2, height/2, 230, 230);

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void serialEvent(Serial myPort) {
  int inByte = myPort.read();
  println(inByte);
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();
      firstContact = true;
      myPort.write('A');
      println('A');
    }
  } else {
    serialArray[serialCount] = inByte;
    serialCount++;
    if (serialCount > 3) {
      xpos = serialArray[0]; 
      ypos = serialArray[1];    
      colorChange = serialArray[2]; 
      buttonRead = boolean(serialArray[3]);

      println("x: " + xpos + " y: " + ypos);
      println("Color: " + colorChange);
      println();
      delay(10);

      myPort.write('A');
      serialCount = 0;
    }
  }
}

void draw() {
  fill(0, 0, colorChange);
  ellipse(xpos, ypos, 5, 5);
  if (!buttonRead) {
    background(255, 0, 0);
    rectMode(CENTER);
    fill(200);
    noStroke();
    rect(width/2, height/2, 235, 235);
  }
}
