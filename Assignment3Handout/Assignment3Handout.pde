ArrayList<Entity> objects = new ArrayList<Entity>();
ArrayList<ParticleSystem> particleSystems = new ArrayList<ParticleSystem>();

void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setOrtho();
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually

  ENEMY_BULLET_COLOR = color(1,0,0);
  PLAYER_BULLET_COLOR = color(0,0,1);

  GrassTop = loadImage("GrassTop.png");
  GrassSide = loadImage("GrassSide.jpg");
  SnowTop = loadImage("SnowTop.jpg");
  SnowSide = loadImage("SnowSide.png");
  EnemyTexture = loadImage("Goomba.png");
  PlayerTexture = loadImage("SpaceShip.png");
  
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
  
  float gamble = random(0,1);
  if(gamble <= SPAWN_PROB)
    objects.add(new Enemy());
  
  //vertex(0,0);
  //vertex(640,0);
  //vertex(320,640);
  
  world.print();
  world.increment();
  
  if(doCollision)
  {
    for(int i = 0; i < objects.size(); i++)
    {
      for(int j = i + 1; j < objects.size(); j++)
      {
        objects.get(i).collide(objects.get(j));
      }
    }
  }
 
  
  for(int i = objects.size() - 1; i >= 0; i--)
  {
    objects.get(i).print();
    objects.get(i).update();
    if(!objects.get(i).alive)
    {
      objects.remove(i);
      i--;
    }
  }
  for(int i = 0; i < particleSystems.size(); i++)
  {
    particleSystems.get(i).print();
    particleSystems.get(i).update();
    if(!particleSystems.get(i).alive)
    {
      particleSystems.remove(i);
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
