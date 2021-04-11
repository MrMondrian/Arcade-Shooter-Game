

abstract class Entity
{
   PVector position;
   boolean alive;
   EntityType type;
   float size;
   
   abstract void update();
   abstract void print();
   abstract void takeHit(Entity other);
   
   public void collide(Entity other)
   {
     if(type != other.type && position.dist(other.position) <= size + other.size)
     {
       takeHit(other);
       other.takeHit(this);
     }
   }
}

enum EntityType
{
  PLAYER_TYPE,
  ENEMY_TYPE  
}
