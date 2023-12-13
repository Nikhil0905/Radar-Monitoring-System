import processing.serial.*;

Serial myPort;
int angle = 0;
int distance = 0;

void setup() {
  size(800, 600);
  myPort = new Serial(this, Serial.list()[0], 9600); // Adjust the index based on your setup
}

void draw() {
  background(255);

  // Draw radar circle
  noFill();
  stroke(0);
  ellipse(width/2, height/2, 400, 400);

  // Draw marker for the ultrasonic sensor position
  float sensorX = width/2;
  float sensorY = height/2;
  fill(0);
  ellipse(sensorX, sensorY, 10, 10);

  // Read data from Arduino
  while (myPort.available() > 0) {
    String dataString = myPort.readStringUntil('\n');
    if (dataString != null) {
      String[] data = dataString.trim().split(",");
      if (data.length == 2) {
        angle = int(data[0]);
        distance = int(data[1]);
      }
    }
  }

  // Plot the detected object on the radar
  float mappedDistance = map(distance, 0, 200, 0, 200);
  float x = sensorX + mappedDistance * cos(radians(angle));
  float y = sensorY + mappedDistance * sin(radians(angle));

  // Draw a point on the radar for the detected object
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);

  // Display angle and distance information
  fill(0);
  textSize(24);
  text("Sensor Position: (" + int(sensorX) + ", " + int(sensorY) + ")", 20, 20);
  text("Angle: " + angle + " degrees", 20, 40);
  text("Distance: " + distance + " cm", 20, 60);
}
