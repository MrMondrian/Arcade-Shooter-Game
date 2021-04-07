ArrayList<Entity> objects = new ArrayList<Entity>();

abstract class Entity
{
   PVector position;
   boolean alive;
   
   abstract void update();
   abstract void print();
}
