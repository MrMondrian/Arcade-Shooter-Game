Player player;

float moveX = 0;
float moveY = 0;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;



abstract class Person extends Entity
{
 
  float size;
  PVector position;
  color c;
  
    public void print()
  {
         
    fill(c);
    //top face
    vertex(position.x - size, position.y + size, position.z);
    vertex(position.x - size, position.y - size, position.z);
    vertex(position.x + size, position.y + size, position.z);
    //topface
    vertex(position.x - size, position.y - size, position.z);
    vertex(position.x + size, position.y - size, position.z);
    vertex(position.x + size, position.y + size, position.z); 
    
  }
}

float MOVE_PROB = 0.01; //processing wouldn't let me make these static in Enemy unless it was final
float SHOOT_PROB = 0.01;
color ENEMY_BULLET_COLOR = color(0,1,0);
float ENEMY_BULLET_SPEED = 0.02;
float SPAWN_PROB = 0.003;
class Enemy extends Person
{
  final static float ENEMY_Z = -0.2;
  
  boolean moving;
  KeyFrame whereTo;
  public Enemy()
  {
    size = 0.2;
    position = new PVector(random(0,2), random(0,0.5),ENEMY_Z);

    c = color(0,1,0);
    moving = false;
    whereTo = null;
    alive = true;
  }
  
  public void update()
  {
    if(!moving)
    {
      float gamble = random(0,1);
      if(gamble <= MOVE_PROB)
      {
        PVector location = new PVector(random(0,2),random(0,2), position.z);
        PVector diff = location.copy().sub(position);
        float time = diff.mag() * 2000000000; //make this not a magic number
        whereTo = new KeyFrame(position.copy(), location, System.nanoTime(), time);
        moving = true;
      }
    }
    else
    {
      position = whereTo.getPosition();
      if(whereTo.finished())
        moving = false;
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
      out = new Bullet(position.copy(), goHome, ENEMY_BULLET_COLOR, ENEMY_BULLET_SPEED);
    }
    return out;
  }
  
}

final float PLAYER_MOVE_SPEED = 0.05;
final float PLAYER_Z = -0.19;
final color PLAYER_BULLET_COLOR = color(0,0,255);
final float PLAYER_BULLET_SPEED = 0.05;
class Player extends Person
{  
  
  final PVector home = new PVector(1, 1.5, PLAYER_Z);
  
  public Player()
  {
     size = 0.15;
     position = home.copy();

     c = color(0,0,1);
     alive = true;
  }
  
  public void print()
  {
    //if(right)
    //  rotateY(PI/6.0);
    //if(left)
    //  rotateY(-PI/6.0);
    //if(up)
    //  rotateX(PI/6.0);
    //if(down)
    //  rotateX(-PI/6.0);
      
    super.print(); 
    
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
      if(position.x + moveX >= 0 && position.x + moveX <=2)
        position.x += moveX;
      
      if(position.y + moveY >= 0 && position.y + moveY <=2)
        position.y += moveY;
    }
  }
  
  
  public Bullet getBullet()
  {
    PVector direction = new PVector(0,-1);
    return new Bullet(position.copy(), direction, PLAYER_BULLET_COLOR, PLAYER_BULLET_SPEED);
  }
}
