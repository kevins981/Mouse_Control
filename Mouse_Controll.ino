const int button = 2;
const int PotenX = 4;
const int PotenY = 5;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(button, INPUT);
  digitalWrite(button, HIGH); // pull up
}

void loop() {
  // put your main code here, to run repeatedly:
  int x = (512 - analogRead(PotenX))/4;
  int y = (512 - analogRead(PotenY))/4;
  Serial.print("Data,");
  Serial.print(x,DEC);
  Serial.print(",");
  Serial.print(y,DEC);
  Serial.print(",");

  if (digitalRead(button) == LOW){
    Serial.print("1"); 
  }
  else {
    Serial.print("0"); 
  }

  Serial.println(","); 
  delay(50);

}
