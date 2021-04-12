// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

final float TILE_SIZE = 0.0625;
final int WORLD_SIZE = 256;
final float SCROLL_SPEED = 0.01;

World world;
class World
{
  WorldSection w1;
  WorldSection w2;
  
  public World()
  {
    w1 = new WorldSection(0);
    w2 = new WorldSection(-6);
  }
  
  public void print()
  {
    w1.print();
    w2.print();
  }
  
  public void increment()
  {
    w1.offset += SCROLL_SPEED;
    if(w1.offset >= 2){
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
    tiles = new Tile[WORLD_SIZE * 9];
    int k = 0;
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


PImage GrassTop;
PImage GrassSide;
PImage SnowTop;
PImage SnowSide;
class Tile
{
  float x;
  float y;
  float tall;
  
  PImage top;
  PImage side;
  
  color c;
  
  public Tile(float _x, float _y)
  {
    x = _x;
    y = _y;
    tall = random(0.5,2);
    c = color(random(0,1), random(0,1), random(0,1));
    
    float gamble = random(0,1);
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
    
    float drawY = y + offset;
    
     pushMatrix();
     translate(x,drawY,-0.5);
     scale(TILE_SIZE);
     scale(1,1,tall);

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
