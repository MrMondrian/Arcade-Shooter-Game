void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  camera(1, 1, (0.5) / tan(PI*30.0 / 180.0), 1,1, 0, 0, 1, 0);
  ortho(-1,1,-1,1);
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually
  
  world = new World();
  player = new Player(1, 1);
  enemies.add(new Enemy());
}

World world;
void draw() {
  background(0,0,0);
  pollKeys();
  player.move(moveX,moveY);
  fill(1,0,1);
  noStroke();
  beginShape(TRIANGLES);
  //vertex(0,0);
  //vertex(640,0);
  //vertex(320,640);
  
  world.print();
  world.increment();
  player.print();
  for(int i = 0; i < enemies.size(); i++)
    enemies.get(i).print();

  endShape();
  
}

void pollKeys()
{
   moveX = 0;
   moveY = 0;
   if(right)
     moveX += MOVE_SPEED;
   if(left)
     moveX -= MOVE_SPEED;
   if(up)
     moveY -= MOVE_SPEED;
   if(down)
     moveY += MOVE_SPEED;
}
