ArrayList<Entity> objects = new ArrayList<Entity>();

abstract class Entity
{
   PVector position;
   boolean alive;
   EntityType type;
   
   abstract void update();
   abstract void print();
   //abstract void takeHit(Entity other);
   
   public void collide(Entity other)
   {
     if(type != other.type)
     {
       //takeHit(other);
       //other.takeHit(this);
     }
   }
}

enum EntityType
{
  PLAYER_TYPE,
  ENEMY_TYPE  
}
