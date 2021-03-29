void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually 
}


void draw() {
}
