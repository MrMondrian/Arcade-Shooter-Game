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
  
  public void print()
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

float MOVE_PROB = 0.01; //probablity an enemy will move an a given frame. not final because it might change with difficulty
float SHOOT_PROB = 0.01; //probability an enemy will shoot on a given frame. not final because it might change with difficulty
color ENEMY_BULLET_COLOR; //color of the enemy. set in the setup function
float ENEMY_BULLET_SPEED = 0.02; //speed of the enemy. not final because it might change with difficulty
float SPAWN_PROB = 0.003; //probabilty a new enemy will spawn on a given frame. not final because it might change with difficulty
PImage EnemyTexture; //global PImage that is the enemy texture. set in setup function
final int FRAMES_PER_SHOT = 6; //how many frames each picture of the frame based animation last
final float ENEMY_Z = 0;//-0.2;
final float ENEMY_SIZE = 0.15;
class Enemy extends Person
{
  
  boolean moving; //whether or not it is current moving
  KeyFrame whereTo; //a keyframe that guides the enemy to its next position
  int moveFrame; //a counter for the frames that have elapsed since movement started. Used for frame based animation
  boolean movingRight;
  public Enemy()
  {
    size = ENEMY_SIZE; //need to set this for collisions. can't just use the global constant
    position = new PVector(random(-1,1), random(0,-1),ENEMY_Z);

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
        PVector diff = location.copy().sub(position);
        float time = diff.mag() * 2000000000; //make this not a magic number
        whereTo = new KeyFrame(position.copy(), location, System.nanoTime(), time);
        moving = true;
        if(diff.x > 0)
          movingRight = true;
        else
          movingRight = false;
      }
    }
    else
    {
      position = whereTo.getPosition();
      moveFrame++;
      if(whereTo.finished())
      {
        moving = false;
        moveFrame = 0;
      }
    }
    
    Bullet add = getBullet();
    if(add != null)
      objects.add(add);
  }
  
  public Bullet getBullet()
  {
    Bullet out = null;
    float gamble = random(0,1);
    if(gamble <= SHOOT_PROB)
    {
      PVector goHome = player.position.copy();
      goHome.sub(position);
      goHome.normalize();
      out = new Bullet(position.copy(), goHome, ENEMY_BULLET_COLOR, ENEMY_BULLET_SPEED, EntityType.ENEMY_TYPE);
    }
    return out;
  }
  
  public void print()
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size);
    
    if(doTextures)
    {
      if(!moving)
        printTextureStill();
      else
      {
        int whichShot = moveFrame / FRAMES_PER_SHOT;
        printTextureMove(whichShot);
      }
    }
    else
    {  
      super.print();
    }
    popMatrix();
  }
  
  //https://forum.processing.org/two/discussion/14568/how-do-i-let-the-tiles-change-color-if-my-goomba-stands-on-them
  public void printTextureStill()
  {
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
  
  public void printTextureMove(int frame)
  {
    frame = frame % 8;
    float xOffset = 0.125 * frame;

    float yOffset;
    if(movingRight)
      yOffset = 0.25;
    else
      yOffset = 0.75;
    
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
  
  public void takeHit(Entity other)
  {
    particleSystems.add(new ParticleSystem(position.copy()));
    if(other instanceof Bullet)
    {
      health -= 0.5;
      if(health <= 0)
      { 
         alive = false; 
      }
    }
    else if(other instanceof Player)
    {
      health = 0;
      alive = false;
    }
  }
  
}

Player player;

float moveX = 0;
float moveY = 0;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;

final float PLAYER_MOVE_SPEED = 0.05;
final float PLAYER_Z = 0;
color PLAYER_BULLET_COLOR;
final float PLAYER_BULLET_SPEED = 0.05;
PImage PlayerTexture; //https://www.pikpng.com/transpng/iRioihh/
class Player extends Person
{  
  
  final PVector home = new PVector(0, 0.5, PLAYER_Z); //0.15
  
  public Player()
  {
     size = 0.15; //magic number
     position = home.copy();

     c = color(0,0,1);
     alive = true;
     appearance = PlayerTexture;
     
     type = EntityType.PLAYER_TYPE;
     
     health = 1;
  }
  
  public void print()
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
    if(moveX == 0 && moveY == 0)
    {
      PVector goHome = home.copy();
      goHome.sub(position);
      goHome.mult(0.015 / (goHome.mag() + 0.1)); //magic numbers
      position.add(goHome);
    }
    else
    {
      if(position.x - size/2.0 + moveX >= -1 && position.x + size/2.0 +  moveX <=1)
        position.x += moveX;
      
      if(position.y - size/2.0 + moveY >= -1 && position.y + size/2.0 + moveY <=1)
        position.y += moveY;
    }
  }
  
  
  public Bullet getBullet()
  {
    PVector direction = new PVector(0,-1);
    PVector location = position.copy();
    return new Bullet(location, direction, PLAYER_BULLET_COLOR, PLAYER_BULLET_SPEED, EntityType.PLAYER_TYPE);
  }
  
  public void takeHit(Entity other)
  {
    //smame result if it's a bullet or an enemy, instant death
    health = 0;
    alive = false;
    particleSystems.add(new ParticleSystem(position.copy()));
  }
}
