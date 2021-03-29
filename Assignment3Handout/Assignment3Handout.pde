void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually
  
  w = new WorldSection(0,0);
}

WorldSection w;
void draw() {
  background(0,0,0);
  
  fill(1,0,1);
  noStroke();
  beginShape(TRIANGLES);
  w.print();
  endShape();
}
