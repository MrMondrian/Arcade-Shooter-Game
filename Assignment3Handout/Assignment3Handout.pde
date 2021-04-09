void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setOrtho();
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually

  GrassTop = loadImage("GrassTop.png");
  GrassSide = loadImage("GrassSide.jpg");
  SnowTop = loadImage("SnowTop.jpg");
  SnowSide = loadImage("SnowSide.png");
  enemyStill = loadImage("Goomba.png");
  
  world = new World();
  
  player = new Player();
  objects.add(player);
  objects.add(new Enemy());
  
   
}


void draw() {
  background(0,0,0);
  pollKeys();
  fill(1,0,1);
  noStroke();
  
  //float gamble = random(0,1);
  //if(gamble <= SPAWN_PROB)
  //  objects.add(new Enemy());
  
  //vertex(0,0);
  //vertex(640,0);
  //vertex(320,640);
  
  world.print();
  world.increment();
  
  for(int i = 0; i < objects.size(); i++)
  {
    objects.get(i).update();
    objects.get(i).print();
    if(!objects.get(i).alive)
    {
      objects.remove(i);
      i--;
    }
  }

  
}

void pollKeys()
{
   moveX = 0;
   moveY = 0;
   if(right)
     moveX += PLAYER_MOVE_SPEED;
   if(left)
     moveX -= PLAYER_MOVE_SPEED;
   if(up)
     moveY -= PLAYER_MOVE_SPEED;
   if(down)
     moveY += PLAYER_MOVE_SPEED;
}
