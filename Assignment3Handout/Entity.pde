// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)


//this abstract class represents all physical objects. ie: bullet, enemy, player
//all entities must be able to draw, update, and collide
//this way, we can store them all in one list and simplify the code with OO
abstract class Entity
{
   PVector position;
   boolean alive;
   EntityType type; //see the enum below for explanation
   float size;
   
   abstract void update();
   abstract void draw();
   abstract void takeHit(Entity other); //if it is hit, change the object state
   
   //checks to see if this object and another object are colliding
   public void collide(Entity other)
   {
     if(type != other.type && position.dist(other.position) <= size + other.size)
     {
       takeHit(other);
       other.takeHit(this);
     }
   }
}


//This enum type helps determine if objects should collide
//if they are player, or are a player bullet, the don't
//same goes for enemy
enum EntityType
{
  PLAYER_TYPE,
  ENEMY_TYPE  
}
