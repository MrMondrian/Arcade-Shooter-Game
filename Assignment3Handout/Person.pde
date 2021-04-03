Player player;

float moveX = 0;
float moveY = 0;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;
final float MOVE_SPEED = 0.05;

abstract class Person
{
 
  float size;
  float x;
  float y;
  float z;
  color c;
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
    fill(c);
    //top face
    vertex(x - size, y + size, z);
    vertex(x - size, y - size, z);
    vertex(x + size, y + size, z);
    //topface
    vertex(x - size, y - size, z);
    vertex(x + size, y - size, z);
    vertex(x + size, y + size, z);    
  }
  
  public void move(float addX, float addY)
  {
   if(x + addX >= 0 && x + addX <=2)
     x += addX;
    
   if(y + addY >= 0 && y + addY <=2)
     y += addY;
   
  }
}

class Enemy extends Person
{
  
}
