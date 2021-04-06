ArrayList<Bullet> bullets = new ArrayList<Bullet>();

class Bullet
{
  final static float BULLET_SIZE = 0.05;
  final static float BULLET_Z = -0.21;
  
  PVector position;
  PVector direction;
  boolean alive;
  float lookAngle;
  float vertexXDiff;
  float vertexYDiff;
  float c;
  
  public Bullet(PVector p, PVector d, color _c)
  {
    position = p;
    p.z = BULLET_Z;
    direction = d;
    alive = true;
    lookAngle = (float)Math.atan(direction.y / direction.x);
    vertexYDiff = sin(PI/6.0) * BULLET_SIZE;
    vertexXDiff = cos(PI/6.0) * BULLET_SIZE;
    c = _c;
  }
  
  public void update()
  {
    PVector toAdd = direction.copy().mult(0.1);//fix magic number
    toAdd.y *= -1;
    position.add(toAdd);
    if(position.x < 0 || position.x > 2 || position.y < 0 || position.y > 2)
      alive = false;
  }
  
  public void print()
  {
    fill(c);
    //rotateZ(lookAngle);
    
    vertex(position.x, position.y - BULLET_SIZE, position.z);
    vertex(position.x - vertexXDiff, position.y + vertexYDiff, position.z);
    vertex(position.x + vertexXDiff, position.y + vertexYDiff, position.z);
  }
}
