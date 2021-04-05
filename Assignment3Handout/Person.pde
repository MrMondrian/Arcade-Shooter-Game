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

class Enemy extends Person
{
  boolean moving;
  KeyFrame whereTo;
  public Enemy()
  {
    size = 0.2;
    x = random(0,2);
    y = random(0,0.5);
    z = -0.2;
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
        whereTo = new KeyFrame();
      }
    }
  }
  

}

class Player extends Person
{
  
  public Player(float _x, float _y)
  {
     size = 0.15;
     x = _x;
     y = _y;
     z = -0.2;
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
   if(x + addX >= 0 && x + addX <=2)
     x += addX;
    
   if(y + addY >= 0 && y + addY <=2)
     y += addY;
   
  }
}
