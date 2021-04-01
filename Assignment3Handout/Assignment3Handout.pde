void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually
  
  w1 = new WorldSection(0,0,0);
  w2 = new WorldSection(0,0,-640);
}

WorldSection w1;
WorldSection w2;
void draw() {
  background(0,0,0);
  
  fill(1,0,1);
  noStroke();
  beginShape(TRIANGLES);
  w1.print();
  w1.offset += 1;
  if(w1.offset >= 640)
    w1.offset = -640;
    
  w2.print();
  w2.offset += 1;
  if(w2.offset >= 640)
    w2.offset = -640;
  endShape();
}
