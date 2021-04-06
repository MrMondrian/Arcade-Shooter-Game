Player player;

float moveX = 0;
float moveY = 0;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;
final float MOVE_SPEED = 0.05;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();





abstract class Person
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

float moveProb = 0.01; //processing wouldn't let me make these static in Enemy unless it was final
float shootProb = 0.1;
color ENEMY_BULLET_COLOR = color(0,1,0);
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
  }
  
  public void update()
  {
    if(!moving)
    {
      float gamble = random(0,1);
      if(gamble <= moveProb)
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
  }
  
  public Bullet getBullet()
  {
    Bullet out = null;
    float gamble = random(0,1);
    if(gamble <= shootProb)
    {
      PVector goHome = player.position.copy();
      goHome.sub(position);
      goHome.normalize();
      out = new Bullet(position.copy(), goHome, ENEMY_BULLET_COLOR);
    }
    return out;
  }
  
}

class Player extends Person
{
  final static float PLAYER_Z = -0.19;
  final color BULLET_COLOR = color(0,0,1);
  
  
  final PVector home = new PVector(1, 1.5, PLAYER_Z);
  
  public Player()
  {
     size = 0.15;
     position = home.copy();

     c = color(0,0,1);
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
    return new Bullet(position.copy(), direction, BULLET_COLOR);
  }
}
