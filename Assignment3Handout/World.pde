// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

final float TILE_SIZE = 0.0625;
final int WORLD_SIZE = 2304; //amount of tiles per world section
final float SCROLL_SPEED = 0.01;

//global world variable
World world;

//the world. it has two sections. when one goes out of view, it teleports back
//I got the idea from the assignment description
class World
{
  WorldSection w1;
  WorldSection w2;
  
  public World()
  {
    w1 = new WorldSection(0); //one section starts at the origin
    w2 = new WorldSection(-6); //one starts behind
  }
  
  public void print()
  {
    w1.print();
    w2.print();
  }
  
  public void increment()
  {
    w1.offset += SCROLL_SPEED; //increment their positions
    if(w1.offset >= 2){ //if they go to far, teleport them backwards
      w1.offset = -9.99;
    }
    w2.offset += SCROLL_SPEED;
    if(w2.offset >= 2) {
      w2.offset = -9.99;
    }
  }
}

class WorldSection
{
  Tile[] tiles;
  

  float offset;
  
  public WorldSection(float o)
  {

    offset = o;
    tiles = new Tile[WORLD_SIZE];
    int k = 0;
    //this nested for loop populates the world section. It creates tile ranging from -3 to 3 in X, 0 to 6 in Y
    for(float j = TILE_SIZE; j <6; j += 2 * TILE_SIZE)
    {
      for(float i = TILE_SIZE - 3; i < 3; i += 2*TILE_SIZE)
      {
        Tile t = new Tile(i, j);
        tiles[k] = t;
        k++;
      }
    }
  }
  
  public void print()
  {
    for(int i = 0; i < tiles.length; i++)
      tiles[i].print(offset);
  }
  
}


//these are all textures that are set in the setup function
PImage GrassTop;
PImage GrassSide;
PImage SnowTop;
PImage SnowSide;
class Tile
{
  float x;
  float y;
  float tall; //this is the weight of the tile, but the height keyword is taken :/
  
  //the textures of this object
  PImage top;
  PImage side;
  
  color c;
  
  public Tile(float _x, float _y)
  {
    x = _x;
    y = _y;
    tall = random(0.5,2); //height is random
    c = color(random(0,1), random(0,1), random(0,1)); //color is random
    
    float gamble = random(0,1); //randomly assign a texture
    if(gamble < 0.5)
    {
      top = GrassTop;
      side = GrassSide;
    }
    else
    {
      top = SnowTop;
      side = SnowSide;
    }
  }
  
  void print(float offset)
  {
    fill(c);
    
    float drawY = y + offset; //the y value of the tile depends on the y value of the world section
    
     pushMatrix();
     translate(x,drawY,-0.5); //translate it. -0.5 in the z is the floor for the tiles
     scale(TILE_SIZE); //now make the whole tile the correct size
     scale(1,1,tall); //scale it in the z, make it the correct height


     //This draws each face of the box in NDC.
     //For the sake of this assignment we only need to draw the 4 faces the user will see
     //reminder: I did not flip the y so up is negative
     
     //Also, I'm placing verticies in the z from 0 to 2 instead of -1 to 1.
     //The point of this is that when I scale the boxes in the z, it only scales in 1 dimension.
     //This way, the bottoms of the boxes will all be on the same level
     beginShape(TRIANGLES);
     
     //if(doTextures)
     if(doTextures)
       texture(side);
     //right side
     vertex(1,1,2,0,0);
     vertex(1,1,0,0,1);
     vertex(1,-1,0,1,1);
     
     vertex(1,1,2,0,0);
     vertex(1,-1,0,1,1);
     vertex(1,-1,2,1,0);
     
     //left side
     vertex(-1,-1,2,0,0);
     vertex(-1,-1,0,0,1);
     vertex(-1,1,0,1,1);
     
     vertex(-1,-1,2,0,0);
     vertex(-1,1,0,1,1);
     vertex(-1,1,2,1,0);
     //front side
     vertex(-1,1,2,0,0);
     vertex(-1,1,0,0,1);
     vertex(1,1,0,1,1);
     
     vertex(-1,1,2,0,0);
     vertex(1,1,0,1,1);
     vertex(1,1,2,1,0);
     endShape();
     
     beginShape(TRIANGLES);
     if(doTextures)
       texture(top);
     //top side
     vertex(-1,-1,2,0,0);
     vertex(-1,1,2,0,1);
     vertex(1,1,2,1,1);
     
     vertex(-1,-1,2,0,0);
     vertex(1,1,2,1,1);
     vertex(1,-1,2,1,0);
     
     endShape();
     popMatrix();
  }
}
