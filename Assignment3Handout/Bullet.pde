// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

final float BULLET_SIZE = 0.06;
final float BULLET_Z = -0.2; //0.1;
class Bullet extends Entity
{
  PVector direction; //where the bullet is headed, a normalized vector
  float lookAngle; //the direction the bullet is pointed
  color c; //the color
  
  public Bullet(PVector p, PVector d, color _c, float s, EntityType t)
  {
    position = p;
    p.z = BULLET_Z;
    
    direction = d;
    direction.mult(s);
    
    alive = true;
    
    //calculate the look angle
    lookAngle = -1 * ((float)Math.atan(-direction.y / direction.x) - PI/2.0);
    if(direction.x < 0)
      lookAngle += PI;

    c = _c;
    type = t;
    size = BULLET_SIZE;
  }
  
  public void update()
   {
    //add the direction the to the position to cause movement
    PVector toAdd = direction;
    position.add(toAdd);
    //check if out of bounds
    if(position.x < -1.5 || position.x > 1.5 || position.y < -1.5 || position.y > 1.5) //make the bound a little bigger than the playing area on purpose
      alive = false;
  }
  
  public void draw()
  {
    fill(c);
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size);
    rotateZ(lookAngle);
    
    //this is the bullet in NDC
    //reminder, I did not flip the y, so up is negative
    beginShape(TRIANGLES);
    vertex(0,-1,0);
    vertex(-0.33,1,0);
    vertex(0.33,1,0);
    endShape();
    
    popMatrix();
  }
  
  public void takeHit(Entity other)
  {
    alive = false; //same result regardless of what it hits. Always dies. Doesn't generate a particle system
  }
}
