#include <Servo.h>

const int trigPin = 3;   // Trig pin of the ultrasonic sensor
const int echoPin = 2;  // Echo pin of the ultrasonic sensor
Servo servoMotor;

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  servoMotor.attach(9);  // Attach the servo motor to pin 11
}

void loop() {
  Serial.begin(9600);  // This line was missing in the previous code

  for (int angle = 0; angle <= 180; angle += 10) {
    servoMotor.write(angle);
    delay(250);  // Adjust the delay as needed

    long duration, distance;
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);

    duration = pulseIn(echoPin, HIGH);
    distance = duration * 0.034 / 2;
6666666
    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);
  }
}
