// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)


//this class represents an enemy or a player
//amde an abstract class to limit code reuse
abstract class Person extends Entity
{
 
  color c;
  PImage appearance; //the texture
  float health; //player or enemy's hp
  
  public void draw()
  {
    fill(c);
    
    //draws a simple square in NDC using triangles
    //reminder, I did not flip the y, so up is negative
    beginShape(TRIANGLES);

    vertex(-1,-1,0);
    vertex(-1,1,0);
    vertex(1,1,0);
    
    vertex(-1,-1,0);
    vertex(1,1,0);
    vertex(1,-1,0);
    endShape();
    
  }
}

//this is where the difficulty is set. the more enemies there are, the harder the game(to a cap)
//these 4 variables are what affect the game's difficulty
int numKills = 0;
int numEnemies = 0;
final int KILLS_PER_DIFFICULTY = 5;
float SHOOT_PROB = 0.007; //probability an enemy will shoot on a given frame. not final because it might change with difficulty
float SPAWN_PROB = 0.005; //probabilty a new enemy will spawn on a given frame. not final because it might change with difficulty

/*
  HOW THE DIFFICULTY SYSTEM WORKS:
    -every time KELLS_PER_DIFFICULTY number of enemies die, increaseDifficulty is called which increases SHOOT_PROB and SPAWN_PROB
    -there is a function called getSpawnProb() that is used to calculate the spawn probabilty
      this function uses SPAWN_PROB, and takes into account how many enemies are live to return a new spawn prob
      the more enemies there are, the less likely a new one is to spawn
*/



float MOVE_PROB = 0.01; //probablity an enemy will move an a given frame. not final because it might change with difficulty
color ENEMY_BULLET_COLOR; //color of the enemy. set in the setup function
float ENEMY_BULLET_SPEED = 0.02; //speed of the enemy. not final because it might change with difficulty

//this is where I got the goomba from
//https://forum.processing.org/two/discussion/14568/how-do-i-let-the-tiles-change-color-if-my-goomba-stands-on-them
PImage EnemyTexture; //global PImage that is the enemy texture. set in setup function

final int FRAMES_PER_SHOT = 6; //how many frames each picture of the frame based animation last
final float ENEMY_Z = -0.1;//-0.2;
final float ENEMY_SIZE = 0.15;
final float ENEMY_HEALTH_PER_HIT = 0.5;

int enemyCount = 0;

class Enemy extends Person
{
    
  boolean moving; //whether or not it is current moving
  KeyFrame whereTo; //a keyframe that guides the enemy to its next position
  int moveFrame; //a counter for the frames that have elapsed since movement started. Used for frame based animation
  boolean movingRight;
  public Enemy()
  {
    size = ENEMY_SIZE; //need to set this for collisions. can't just use the global constant
    position = new PVector(random(-1,1), random(0,-1),ENEMY_Z - enemyCount*0.001); //the -enemyCount*0.001 is there is help z-fighting
    enemyCount++;
  
    
    c = color(1,0,0); //emeies are red
    
    //set default values
    moving = false;
    whereTo = null;
    alive = true;
    moveFrame = 0;
    
    appearance = EnemyTexture;
    movingRight = true; //just a default value
    
    type = EntityType.ENEMY_TYPE;
    
    health = 1; //initial health is one
    numEnemies++;
  }
  
  public void update()
  {
    if(!moving)
    {
      //random chance it might start moving
      float gamble = random(0,1);
      if(gamble <= MOVE_PROB)
      {
        //make a random location
        PVector location = new PVector(random(-0.8,0.8),random(-0.9,0.6), position.z);
        //vector from current position to keyframe position
        PVector diff = location.copy().sub(position);
        //set the time based on how far we are traveling. guarantees all keyframes have the same speed
        float time = diff.mag() * 2000000000; //make this not a magic number
        //make the keyframe
        whereTo = new KeyFrame(position.copy(), location, System.nanoTime(), time);
        moving = true;
        
        //this is for textures. need to flip it if we are moving left
        if(diff.x > 0)
          movingRight = true;
        else
          movingRight = false;
      }
    }
    else
    {
      //if we are currently moving, get the next position from the keyframe
      position = whereTo.getPosition();
      moveFrame++;
      if(whereTo.finished())
      {
        moving = false;
        moveFrame = 0;
      }
    }
    
    //shoot a bullet
    Bullet add = getBullet();
    if(add != null)
      objects.add(add);
  }
  
  //returns a new bullet or null
  public Bullet getBullet()
  {
    Bullet out = null;
    float gamble = random(0,1);
    if(gamble <= SHOOT_PROB)
    {
      //make a new bullet
      PVector goHome = player.position.copy();
      goHome.sub(position);
      goHome.normalize();
      //goHome is now a normalized vector point from out position to the player's
      out = new Bullet(position.copy(), goHome, ENEMY_BULLET_COLOR, ENEMY_BULLET_SPEED, EntityType.ENEMY_TYPE);
    }
    return out;
  }
  
  public void draw()
  {
    //do transformations
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size);
    
    
    if(doTextures)
    {
      //draw still texture if not moving
      if(!moving)
        drawTextureStill();
        
      //do frame based animation
      else
      {
        int whichShot = moveFrame / FRAMES_PER_SHOT;
        drawTextureMove(whichShot);
      }
    }
    else
    {  
      super.draw();
    }
    popMatrix();
  }
  
  //https://forum.processing.org/two/discussion/14568/how-do-i-let-the-tiles-change-color-if-my-goomba-stands-on-them
  public void drawTextureStill()
  {
    //this draws the enemy textured in NDC with 2 triangles
    //reminder: I didn't flip the y, so up is negative
    
    beginShape(TRIANGLES);
    if(doTextures)
      texture(appearance);
    vertex(-1,-1,0,0,0.5);
    vertex(-1,1,0,0,0.625);
    vertex(1,1,0,0.125,0.625);
    
    vertex(-1,-1,0,0,0.5);
    vertex(1,1,0,0.125,0.625);
    vertex(1,-1,0,0.125,0.5);
    endShape(); 
  }
  
  //draws the enemy using frame based animation
  public void drawTextureMove(int frame)
  {
    
    frame = frame % 8; //we have 8 frames, need to use modulus to pick the right one
    
    //since all the frames are in 1 png, we need offsets to find the right texels
    float xOffset = 0.125 * frame;

    //the y offset determines which direction the goomba faces. you can look at the png to see why
    float yOffset;
    if(movingRight)
      yOffset = 0.25;
    else
      yOffset = 0.75;
    
    //I was having some issues where the png wasn't quite perfect so the goomba was moving around in its box
    //So I fidgured out these adjustments to fix it.
    float lowX = xOffset + 0.003 * frame;
    float highX = 0.125 + xOffset + 0.003 * frame - 0.01;
    
    float lowY = yOffset;
    float highY = yOffset + 0.125;
    
    beginShape(TRIANGLES);
    if(doTextures)
      texture(appearance);
    
    
    
    vertex(-1,-1,0,lowX,lowY);
    vertex(-1,1,0,lowX,highY);
    vertex(1,1,0,highX,highY);
    
    vertex(-1,-1,0,lowX,lowY);
    vertex(1,1,0,highX,highY);
    vertex(1,-1,0,highX,lowY);
    endShape(); 
  }
  
  //changes this object's state after being hit by another object
  public void takeHit(Entity other)
  {
    particleSystems.add(new ParticleSystem(position.copy())); //generate a new particle system if hit
    if(other instanceof Bullet)
    {
      health -= ENEMY_HEALTH_PER_HIT;
      if(health <= 0)
      { 
         alive = false; 
         numKills++;
         if(numKills % KILLS_PER_DIFFICULTY == 0)
           increaseDifficulty();
         numEnemies--;
      }
    }
    else if(other instanceof Player)
    {
      //die instantly if player is touched
      health = 0;
      alive = false;
      numKills++;
      if(numKills % KILLS_PER_DIFFICULTY == 0)
        increaseDifficulty();
      numEnemies--;
    }
  }
  
}

//the global player variable
Player player;

float moveX = 0; //the amount the player is moving in the x direction in a given frame
float moveY = 0; ////the amount the player is moving in the y direction in a given frame

//these booleans indicate whether the player is moving in that direction
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;

final float PLAYER_MOVE_SPEED = 0.05;
final float PLAYER_Z = 0;
color PLAYER_BULLET_COLOR; //value of this is setup in the setup function
final float PLAYER_BULLET_SPEED = 0.1;
PImage PlayerTexture; //this is where I got the player texture from https://www.pikpng.com/transpng/iRioihh/
final float PLAYER_SIZE = 0.1;
final float PLAYER_RETURN_SPEED = 0.015;
final float PLAYER_HEALTH_PER_HIT = 1;

class Player extends Person
{  
  
  final PVector home = new PVector(0, 0.5, PLAYER_Z); //this position is where the player returns to when not moving
  
  public Player()
  {
     size = PLAYER_SIZE;
     position = home.copy(); //the initial starting position is the home position

     c = color(0,0,1); //players are blue
     alive = true;
     appearance = PlayerTexture;
     
     type = EntityType.PLAYER_TYPE;
     
     health = 1; //intial health is 1
  }
  
  public void draw()
  {
    pushMatrix();
    
    translate(position.x, position.y, position.z);
    scale(size);
    if(right)
      rotateY(PI/6.0);
    if(left)
      rotateY(-PI/6.0);
    if(up)
      rotateX(PI/6.0);
    if(down)
      rotateX(-PI/6.0);
    
    fill(c);
    
    //this draws the player in NDC using 2 triangles
    //reminder: I did not flip the y so up is negative
    beginShape(TRIANGLES);
    if(doTextures)
      texture(appearance);
    vertex(-1,-1,0,0,0);
    vertex(-1,1,0,0,1);
    vertex(1,1,0,1,1);
    
    vertex(-1,-1,0,0,0);
    vertex(1,1,0,1,1);
    vertex(1,-1,0,1,0);
    endShape(); 
    
    popMatrix();
  }
  
  public void update()
  {
    if(moveX == 0 && moveY == 0) //if not moving, drift to the home position
    {
      PVector goHome = home.copy();
      goHome.sub(position);
      //go home is now a vector from the current position to the home position
      //however it isn't enough just to add this vector to the current position
      //we need to scale it with distance so that speed is somewhat constant
      //so we divide the speed by the distance
      //the + 0.1 is to prevent division by 0
      //another way to do this would've been to normalize the vector, but this makes it look really smooth so I kept it
      goHome.mult(PLAYER_RETURN_SPEED / (goHome.mag() + 0.1)); 
      position.add(goHome);
    }
    else
    {
      //if we are moving, it the current move values to the position if they don't exceed the boundaries
      if(position.x - size/2.0 + moveX >= -1 && position.x + size/2.0 +  moveX <=1)
        position.x += moveX;
      
      if(position.y - size/2.0 + moveY >= -1 && position.y + size/2.0 + moveY <=1)
        position.y += moveY;
    }
  }
  
  //returns a bullet fired by the player
  public Bullet getBullet()
  {
    //the bullet direction is always up
    //remember that up is negative in my version
    PVector direction = new PVector(0,-1);
    PVector location = position.copy();
    location.y -= size;
    return new Bullet(location, direction, PLAYER_BULLET_COLOR, PLAYER_BULLET_SPEED, EntityType.PLAYER_TYPE);
  }
  
  //changes the object state when it collides with another entity
  public void takeHit(Entity other)
  {
    if(other instanceof Bullet)
    {
      health -= PLAYER_HEALTH_PER_HIT;
      if(health <= 0)
        alive = false;
    }
    else if(other instanceof Enemy)
    {
      health = 0;
      alive = false;
    }
    particleSystems.add(new ParticleSystem(position.copy()));
  }
}
