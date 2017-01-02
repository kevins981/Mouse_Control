import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Dimension;
import processing.serial.*;

Serial myPort;
arduMouse myMouse;

public static final short LF = 10;

int posX,posY,btn;

void setup(){
   size(200, 200);
   myPort = new Serial(this, Serial.list()[0], 9600);
   myMouse = new arduMouse();
   btn = 0;
  
}

void draw(){
  if (btn != 0){
    myMouse.move(posX,posY);
  }
  
  
}

void serialEvent(Serial p){
  String message = myPort.readStringUntil(LF);
  
  if (message!= null){
    
    String [] data = message.split(",");
    
    
    if (data[0].equals("Data")){
      //println(data[0]+" "+data[1]+" "+data[2]+" "+data[3]+" ");
      if (data.length > 3){
        
        try{
         posX = Integer.parseInt(data[1]);
         posY = Integer.parseInt(data[2]);
         btn = Integer.parseInt(data[3]);
        }
        catch (Throwable t){
          println(".");
          print(message);
        }
         
      }
      
    }
    
  }
  //println(posX+" "+posY+" "+btn);
  
}

class arduMouse{
  Robot myRobot;
  static final short rate = 4;
  int centerX, centerY;
  
  arduMouse(){ //constructor 
    try{
      myRobot = new Robot();
    }
    catch (AWTException e) {
      e.printStackTrace();
    }
    
    Dimension screen = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
    centerY = (int)screen.getHeight()/2;
    centerX = (int)screen.getWidth()/2;
    
  }
  
  
  void move(int offsetX, int offsetY){
    myRobot.mouseMove(centerX+(rate*offsetX), centerY-(rate*offsetY));
  }
}