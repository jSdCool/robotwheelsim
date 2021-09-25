import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlIO control;
ControlDevice stick;
float px, py,FLR=0,FRR=0,BLR=0,BRR=0,centerDist;
int radius=150;
PShape wheel;
 float frontLeftPower = 0,frontRightPower = 0,backLeftPower = 0,BackRightPower = 0;
 float speed=5*(float)Math.PI/180.0;
 
 
public void setup() {
  size(400, 400,P3D);
  // Initialise the ControlIO
  surface.setTitle("wheel simulation");
  control = ControlIO.getInstance(this);
  // Find a joystick that matches the configuration file. To match with any 
  // connected device remove the call to filter.
  stick = control.filter(GCP.STICK).getMatchedDevice("joystick");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }

  
  wheel=loadShape("data/wheel/tinker.obj");
}

public void getUserInput() {
  px = (int)(stick.getSlider("X").getValue()*100)/100.0;
  py = -1*(int)(stick.getSlider("Y").getValue()*100)/100.0;
}

void draw(){
  getUserInput();
  background(255);
  
  camera(200,300,400,200,200,0,0,1,0);
  directionalLight(200,200,200,0.5,-0.87,0.34);
  ambientLight(150,150,150);
  fill(0);
  textSize(40);
  textAlign(CENTER,CENTER);
  float angle =atan2(py,px);
  centerDist=clipe((float)Math.sqrt(Math.pow(px,2)+Math.pow(py,2)),0,1);
  if(centerDist<=0.05){
    centerDist=0;
  }
  
  text(degrees(atan2(py,px)),200,200);
  text(px+"  "+py,200,200+40);
  text(centerDist,200,280);
  
  ellipse(200+cos(angle)*(radius*centerDist),200-sin(angle)*(radius*centerDist),10,10);
  fill(0,255,0);
  box(10);
  fill(0);
  textSize(10);
  translate(100,100,80);
  rotateX(FLR);
  shape(wheel);
  rotateX(-FLR);
  translate(-100,-100,-80);
  text(degrees(frontLeftPower),120,80);
  
  translate(300,100,80);
  rotateX(FRR);
  shape(wheel);
  rotateX(-FRR);
  translate(-300,-100,-80);
  text(degrees(frontRightPower),280,80);
  translate(100,300,80);
  rotateX(BLR);
  shape(wheel);
  rotateX(-BLR);
  translate(-100,-300,-80);
  text(degrees(backLeftPower),120,280);
  translate(300,300,80);
  rotateX(BRR);
  shape(wheel);
  rotateX(-BRR);
  translate(-300,-300,-80);
  text(degrees(BackRightPower),280,280);
  
  frontLeftPower = clipe(Math.sin(angle)+Math.cos(angle),-1,1)*speed*centerDist;
  frontRightPower = clipe(Math.sin(angle)-Math.cos(angle),-1,1)*speed*centerDist;
  backLeftPower = clipe(Math.sin(angle)-Math.cos(angle),-1,1)*speed*centerDist;
  BackRightPower= clipe(Math.sin(angle)+Math.cos(angle),-1,1)*speed*centerDist;
  
  FLR+=frontLeftPower;
  FRR+=frontRightPower;
  BLR+=backLeftPower;
  BRR+=BackRightPower;
  

  
}

float clipe(double in,float min,float max){
  if(in>max){
    return max;
  }
  if(in < min){
   return min; 
  }
  return (float)in;
}
