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
    position.add(direction); //move the particle
    direction.mult(0.96); //decelerate a little
    direction.z += PARTICLE_GRAVITY; //account for gravity
    life -= LIFE_PER_FRAME; //derement life
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
    
    //draws a simple quad in NDC
    //reminder, I did not flip the y, so up is negative
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
  { //generates 100 random particles that have the same starting position
    particles = new ArrayList<Particle>();
    for(int i = 0; i < 100; i++)
    {
      particles.add(new Particle(position.copy()));
    }
    alive = true;
  }
  
  public void update()
  {
    //updates every particle
    //remove it if it's dead
    for(int i = 0; i < particles.size(); i++)
    {
      particles.get(i).update();
      if(!particles.get(i).alive)
      {
        particles.remove(i);
        i--;
      }
    }
    //the system is dead if all particles are dead
    if(particles.size() == 0)
      alive = false;
  }
  
  public void print()
  {
    //prints every particle 
    for(int i = 0; i < particles.size(); i++)
    {
       particles.get(i).print();
    }
  }
}
