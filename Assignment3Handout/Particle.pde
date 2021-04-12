// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

final float PARTICLE_GRAVITY = -0.002;
final float LIFE_PER_FRAME = 0.001; //this is how much life is lost every frame
final float PARTICLE_SIZE = 0.01;

class Particle
{
   
  PVector position;
  PVector direction;
  float life; //how much life is left
  float speed;
  float angle; //a random rotation
  color c;
  boolean alive;
  
  public Particle(PVector p)
  {
    alive = true;
    position = p;
    direction = new PVector(random(-1,1),random(-1,1),random(-1,1)); //generate a random direction
    speed = random(0,0.1); //generate a random speed
    direction.mult(speed);
    life = 1; //life starts off at 1
    angle = random(0,PI/2); //make a random angle
    c = color(random(0.5,1),random(0.25,0.75),random(0,0.5)); //make a random color that is vaguely orange
    
  }
  
  public void update()
  {
    position.add(direction);
    direction.mult(0.96);
    direction.z += PARTICLE_GRAVITY;
    life -= LIFE_PER_FRAME;
    if(life <= 0)
      alive = false;
  }
  
  public void print()
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(PARTICLE_SIZE);
    rotate(angle);
    fill(c);
    beginShape(QUADS);
    vertex(-1,-1,0);
    vertex(-1,1,0);
    vertex(1,1,0);
    vertex(1,-1,0);
    endShape();
    
    popMatrix();
  }
  
}



class ParticleSystem
{
  
  ArrayList<Particle> particles;
  boolean alive;
  
  public ParticleSystem(PVector position)
  {
    particles = new ArrayList<Particle>();
    for(int i = 0; i < 100; i++)
    {
      particles.add(new Particle(position.copy()));
    }
    alive = true;
  }
  
  public void update()
  {
    for(int i = 0; i < particles.size(); i++)
    {
      particles.get(i).update();
      if(!particles.get(i).alive)
      {
        particles.remove(i);
        i--;
      }
    }
    if(particles.size() == 0)
      alive = false;
  }
  
  public void print()
  {
    
    for(int i = 0; i < particles.size(); i++)
    {
       particles.get(i).print();
    }
  }
}
