final float PARTICLE_GRAVITY = 0.098;
final float LIFE_PER_FRAME = 0.000;
final float PARTICLE_SIZE = 0.1;

class Particle
{
   
  PVector position;
  PVector direction;
  float life;
  float speed;
  float angle;
  color c;
  boolean alive;
  
  public Particle(PVector p)
  {
    position = p;
    direction = new PVector(random(0,1),random(0,1),random(0,1));
    direction.normalize();
    speed = 0;//random(0,0.1);
    direction.mult(speed);
    life = 1;
    angle = random(0,PI/2);
    c = color(random(0.5,1),random(0.25,0.75),random(0,0.5));
    
  }
  
  public void update()
  {
    //position.add(direction);
    direction.z += PARTICLE_GRAVITY;
    life -= LIFE_PER_FRAME;
    if(life <= 0)
      alive = false;
  }
  
  public void print()
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    //scale(PARTICLE_SIZE);
    //rotate(angle);
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
      particles.add(new Particle(position));
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
      particles.get(i).print();
  }
}
