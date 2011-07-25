
/*
 * Midi iPad sketch
 *
 * Wave your hand over the LDR and press the button. Play music on attached MIDI device.
 * Works well with Pianist Pro
 *
 */
 
const int ledPin = 13;   // Status LED
const int ldrPin = 0;    // Which pin is the light-dependent resistor (photoresistor) 
const int buttonPin = 2; // The "play" button

int last_read = LOW;

void setup() {

  pinMode(buttonPin,INPUT);

  // Initialize serial with the MIDI bit rate (31250)
  Serial.begin(31250);
  
  for (int i = 0; i < 3; i++) {
    blink(100);
  }
}

void loop () {

  int val = analogRead(ldrPin);

  byte note = val / 8;  // convert value to value between 0 and 127

  int button = digitalRead(buttonPin);
  if (last_read == LOW) {
    if (button == HIGH) {
      playNote(note);
    } 
  }
  last_read = button;

}

void playNote(byte note) {
  Serial.print(0x90, BYTE); // Note on, channel 0
  Serial.print(note, BYTE); // value of the note
  Serial.print(0x64, BYTE); // Velocity 
  blink(10);
}

void blink(int pause) {
  digitalWrite(ledPin, HIGH);
  delay(pause);
  digitalWrite(ledPin, LOW);
  delay(pause);
}
