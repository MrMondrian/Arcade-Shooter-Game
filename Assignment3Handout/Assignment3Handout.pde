ArrayList<Entity> objects = new ArrayList<Entity>();
ArrayList<ParticleSystem> particleSystems = new ArrayList<ParticleSystem>();

void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setOrtho();
  
  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually

  currentBonusFrame = 0;
  inBonus = false;

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
  
  if(inBonus)
    bonus();
  
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

final float FRAMES_FOR_BONUS = 50;
int currentBonusFrame;
PMatrix3D startMatrix;
PMatrix3D endMatrix;
PMatrix3D startCamera;
PMatrix3D endCamera;
boolean inBonus;
public void startBonus()
{
  inBonus = true;
  currentBonusFrame = 0;
  
  startMatrix = getProjection();
  
  if(isOrtho)
  {
    setPerspective();
    endMatrix = getProjection();
    isOrtho = false;
  }
  else
  {
    setOrtho();
    endMatrix = getProjection();
    isOrtho = true;
  }
  
  bonus();
}

public void bonus()
{
  float t = currentBonusFrame / FRAMES_FOR_BONUS;
  setProjection(lerpMatrix(t, startMatrix, endMatrix));
  
  currentBonusFrame++;
  if(currentBonusFrame == FRAMES_FOR_BONUS)
  {
    inBonus = false;
    setProjection(endMatrix);
  }
}

public PMatrix3D lerpMatrix(float t, PMatrix3D a, PMatrix3D b)
{
  PMatrix3D aCopy = a.get();
  PMatrix3D bCopy = b.get();
  multMatrix(aCopy, 1-t);
  multMatrix(bCopy, t);
  

  
  aCopy.m00 += bCopy.m00;
  aCopy.m01 += bCopy.m01;
  aCopy.m02 += bCopy.m02;
  aCopy.m03 += bCopy.m03;
  
  aCopy.m10 += bCopy.m10;
  aCopy.m11 += bCopy.m11;
  aCopy.m12 += bCopy.m12;
  aCopy.m13 += bCopy.m13;
  
  aCopy.m20 += bCopy.m20;
  aCopy.m21 += bCopy.m21;
  aCopy.m22 += bCopy.m22;
  aCopy.m23 += bCopy.m23;
  
  aCopy.m30 += bCopy.m30;
  aCopy.m31 += bCopy.m31;
  aCopy.m32 += bCopy.m32;
  aCopy.m33 += bCopy.m33;
  

  
  return aCopy;
}

public void multMatrix(PMatrix3D mat, float v)
{
  mat.m00 *= v;
  mat.m01 *= v;
  mat.m02 *= v;
  mat.m03 *= v;
  
  mat.m10 *= v;
  mat.m11 *= v;
  mat.m12 *= v;
  mat.m13 *= v;
  
  mat.m20 *= v;
  mat.m21 *= v;
  mat.m22 *= v;
  mat.m23 *= v;
  
  mat.m30 *= v;
  mat.m31 *= v;
  mat.m32 *= v;
  mat.m33 *= v;
  
}
