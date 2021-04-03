Player player;

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
}

class Enemy extends Person
{
  
}
