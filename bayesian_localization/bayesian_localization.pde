boolean[] cells;
float[] probabilities;

int numCells = 10;
int currentPosition;
int doorWidth = 20;
int doorHeight = 50;
// inaccurate senor probabilites
float hitError = 0.6;
float missError = 0.2;

boolean showPosition = false;

void setup() {
  size(400, 220);
  cells = new boolean[numCells];
  probabilities = new float[numCells];
  for (int i = 0; i < cells.length; i++) {
    cells[i] = (random(1) > 0.7);
    probabilities[i] = 1.0/cells.length;
  }
  
  currentPosition = (int)random(numCells);
}

void draw() {
  background(255);
  drawSensorReading();
  
  if(showPosition){
    fill(0);
    text("True position: " + currentPosition, 50, 200);
  }
  
  translate(10, 10);
  drawCells();
  
  translate(0, 150);
  drawProbabilities();
}
void sense(boolean sensorReading){
  float[] newProbs = new float[probabilities.length];
  
  for(int i = 0; i < cells.length; i++) {
    if(cells[i] == sensorReading){
      newProbs[i] = probabilities[i] * hitError;
    } else {
      newProbs[i] = probabilities[i] * missError;
    }
  }
  
  probabilities = newProbs;
  
  // now we have to normalize, i.e.
  // make sure all the probabilities add up to 1
  float sum = 0;
  for(float i : probabilities){
    sum += i;
  }
    
  for(int i = 0; i < probabilities.length; i++){
    probabilities[i] /= sum;
  }
}

void move(int move){
  boolean[] newCells = new boolean[cells.length];
  
  for(int i = 0; i < cells.length; i++){
    int j = (i+(cells.length + move)) % cells.length;
    
    newCells[i] = cells[j];
  }
  
  cells = newCells;
}



void drawProbabilities(){
  pushMatrix();
  pushStyle();
  stroke(0);
  noFill();
  float scale = 0.8;
  scale(scale);
  
  beginShape();
  for(int i = 0; i < cells.length; i++) {
    float doorX = (doorWidth+5) * i * 1/scale;
    vertex(doorX+doorWidth/2, probabilities[i]*-100);
    pushStyle();
    fill(125);
    text(nf(probabilities[i],1,2), doorX, 15); 
    popStyle(); 
  }
  endShape();
  popStyle();
  popMatrix();
}

void drawSensorReading() {
  pushMatrix();
  pushStyle();
  translate(width-100, 10); 

  fill(0);
  text("SENSOR", 0, 10);
  noFill();
  stroke(0);
  rect(0, 20, 90, 100);

  if (takeSensorReading()) {
    pushMatrix();
    translate(30, 30);
    drawDoor();
    popMatrix();
  }

  popStyle();
  popMatrix();
}

boolean takeSensorReading() {
  // perfect measurement
  return cells[currentPosition];
}

void drawCells() {

  pushStyle();

  pushMatrix();
  for (int i = 0; i < cells.length; i++) {
    int doorX = (doorWidth+5) * i;

    if (cells[i]) {
      pushMatrix();
      translate(doorX, 0);
      drawDoor();
      popMatrix();
    }
    fill(0);
    text(i, doorX-5+doorWidth/2, + doorHeight+15);
  }
  popMatrix();
  popStyle();
}

void drawDoor() {
  pushMatrix();
  pushStyle();
    fill(110, 50, 50);
  stroke(0);
  rect(0, 0, doorWidth, doorHeight);
  popStyle();
  popMatrix();
}

void keyPressed(){
  if(key == ' '){
    sense(takeSensorReading());
  }
  
  if(key == '='){
    move(1);
  }
  if(key == '-'){
    move(-1);
  }
  
  if(key == 'r'){
    showPosition = !showPosition;
  }
  saveFrame("bayesian-localization-####.png");
}
