// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

//all the active objects that can collide (bullet, enemy, player)
ArrayList<Entity> objects = new ArrayList<Entity>();
//all the active particle systems
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
  
  SHOOT_PROB = 0.007;
  SPAWN_PROB = 0.005;


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
  
  noStroke();
}


void draw() {
  background(0,0,0);
  pollKeys();
  
  //spawn a new enemy randomly
  float gamble = random(0,1);
  if(gamble <= getSpawnProb())
    objects.add(new Enemy());
  
  //this lerps the projection and camera if we are in the middle of that
  if(inBonus)
    bonus();
  
  //this draws then moves up the world
  world.draw();
  world.increment();
  
  //for all objects, check if it collides with any other object
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
 
  //for every active object (bullet, enemy, player)
  //update it's position,
  //draw it
  //delete it if it's dead
  for(int i = objects.size() - 1; i >= 0; i--)
  {
    objects.get(i).draw();
    objects.get(i).update();
    if(!objects.get(i).alive)
    {
      objects.remove(i);
      i--;
    }
  }
  
  //for every active particle system
  //update it's position,
  //draw it
  //delete it if it's dead
  for(int i = 0; i < particleSystems.size(); i++)
  {
    particleSystems.get(i).draw();
    particleSystems.get(i).update();
    if(!particleSystems.get(i).alive)
    {
      particleSystems.remove(i);
      i--;
    }
    
  }
}

//this method sets the distance to move the players based on global direction booleans
//in the key pressed method, we set the booleans based on input
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

final float FRAMES_FOR_BONUS = 50; //how many frames the bonus takes
int currentBonusFrame; //how for along we are
PMatrix3D startProj; //initial projection, a value of the lerp
PMatrix3D endProj; //b value of the lerp
PMatrix3D startCamera;
PMatrix3D endCamera;
boolean inBonus; //whether we are currently doing the bonus
public void startBonus()
{
  inBonus = true;
  currentBonusFrame = 0;
  
  startProj = getProjection();
  startCamera = getCamera();
  
  if(isOrtho)
  {
    setPerpProj(); //we do this just so the endMatrix is the current projection so we can use getProjection to get it
    endProj = getProjection();
    
    setPerpCamera();
    endCamera = getCamera();
    
    isOrtho = false;
  }
  else
  {
    setOrthoProj();
    endProj = getProjection();
    
    setOrthoCamera();
    endCamera = getCamera();
    isOrtho = true;
  }
  
  bonus();
}

public void bonus()
{
  //find linear t
  float t = currentBonusFrame / FRAMES_FOR_BONUS;
  
  //make t ease in/out
  t *= 2;
  float t1;
  if(t < 1)
  {
    t1 = (1 - cos(t * PI/2.0)) / 2.0;
  }
  else
  {
    t1 = 0.5 +  (sin((t-1) * PI/2.0)) /2.0;
  }
  
  //set the projection
  setProjection(lerpMatrix(t1,startProj, endProj));
  //set the Camera
  setCamera(lerpMatrix(t1, startCamera, endCamera));
  
  //check to if we're finished
  currentBonusFrame++;
  if(currentBonusFrame == FRAMES_FOR_BONUS)
  {
    inBonus = false;
    setProjection(endProj);
    setCamera(endCamera);
  }
}

//lerps to matricies
public PMatrix3D lerpMatrix(float t, PMatrix3D a, PMatrix3D b)
{
  PMatrix3D aCopy = a.get();
  PMatrix3D bCopy = b.get();
  
  //multiply them by their coefficients
  multMatrix(aCopy, 1-t);
  multMatrix(bCopy, t);
  
  //add them together  
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

//multiplies matrix by a scalar
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

public void increaseDifficulty()
{
  SHOOT_PROB *= 5.0/4.0;
  SPAWN_PROB *= 5.0/4.0;
  println(SPAWN_PROB, SHOOT_PROB);
}

public float getSpawnProb()
{
  float out = 0.05;
  if(numEnemies > 0)
    out = SPAWN_PROB - numEnemies*0.001;
  return out;
  
}
