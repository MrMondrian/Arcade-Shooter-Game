Player player;

float moveX = 0;
float moveY = 0;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;
final float MOVE_SPEED = 0.05;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

final float PERSON_Z = -0.2;

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

class Enemy extends Person
{
  boolean moving;
  KeyFrame whereTo;
  public Enemy()
  {
    size = 0.2;
    position = new PVector(random(0,2), random(0,0.5),PERSON_Z);

    c = color(0,1,0);
    moving = false;
    whereTo = null;
  }
  
  public void update()
  {
    if(!moving)
    {
      float gamble = random(0,1);
      if(gamble >= 0.99)
      {
        PVector location = new PVector(random(0,2),random(0,2), PERSON_Z);
        whereTo = new KeyFrame(position.copy(), location, System.nanoTime(), 2000000000);
        println("START");
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
  

}

class Player extends Person
{
  
  public Player(float _x, float _y)
  {
     size = 0.15;
     position = new PVector(_x, _y, PERSON_Z);

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
  
  public void move(float addX, float addY)
  {
   if(position.x + addX >= 0 && position.x + addX <=2)
     position.x += addX;
    
   if(position.y + addY >= 0 && position.y + addY <=2)
     position.y += addY;
 
  }
}
