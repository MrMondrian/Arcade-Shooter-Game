
final float BULLET_SIZE = 0.06;
final float BULLET_Z = -0.21;
class Bullet extends Entity
{
  PVector direction;
  float lookAngle;
  float vertexXDiff;
  float vertexYDiff;
  float c;
  float speed;
  
  public Bullet(PVector p, PVector d, color _c, float s)
  {
    position = p;
    p.z = BULLET_Z;
    direction = d;
    alive = true;
    lookAngle = -1 * ((float)Math.atan(-direction.y / direction.x) - PI/2.0);
    if(direction.x < 0)
      lookAngle += PI;
    vertexYDiff = sin(PI/6.0) * BULLET_SIZE;
    vertexXDiff = cos(PI/6.0) * BULLET_SIZE;
    c = color(0,0,1);
    speed = s;
  }
  
  public void update()
   {
    PVector toAdd = direction.copy().mult(speed);//fix magic number
    position.add(toAdd);
    if(position.x < -1.5 || position.x > 1.5 || position.y < -1.5 || position.y > 1.5)
      alive = false;
  }
  
  public void print()
  {
    fill(0,0,0);
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(BULLET_SIZE);
    rotateZ(lookAngle);
    beginShape(TRIANGLES);
    //vertex(position.x, position.y - 3*BULLET_SIZE, position.z);
    //vertex(position.x - vertexXDiff, position.y + vertexYDiff, position.z);
    //vertex(position.x + vertexXDiff, position.y + vertexYDiff, position.z);
    vertex(0,-1,0);
    vertex(-0.33,1,0);
    vertex(0.33,1,0);
    endShape();
    popMatrix();
  }
}
