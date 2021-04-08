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
    if(w1.offset >= 3){
      w1.offset = -8.99;
    }
    w2.offset += SCROLL_SPEED;
    if(w2.offset >= 3) {
      w2.offset = -8.99;
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
      for(float i = TILE_SIZE - 2; i < 4; i += 2*TILE_SIZE)
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

class Tile
{
  float x;
  float y;
  float z;
  
  color c;
  
  public Tile(float _x, float _y)
  {
    x = _x;
    y = _y;
    z = random(-1,1) * 0.1 - 0.5;
    c = color(random(0,1), random(0,1), random(0,1));
  }
  
  public void print(float offset)
  {
    fill(c);
    float drawY = y + offset;
    beginShape(TRIANGLES);
    //left face
    vertex(x - TILE_SIZE, drawY - TILE_SIZE, z);
    vertex(x - TILE_SIZE, drawY - TILE_SIZE, -1);
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, -1);
    
    //left face
    vertex(x - TILE_SIZE, drawY - TILE_SIZE, z);
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, -1);
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, z);
    
    //right face
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, -1);
    vertex(x + TILE_SIZE, drawY - TILE_SIZE, -1);
    
    //right face
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY - TILE_SIZE, -1);
    vertex(x + TILE_SIZE, drawY - TILE_SIZE, z);
    
    //front face
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, z);
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, -1);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, -1);
    //front face
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, -1);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, z);
    
    //top face
    vertex(x - TILE_SIZE, drawY + TILE_SIZE, z);
    vertex(x - TILE_SIZE, drawY - TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, z);
    //topface
    vertex(x - TILE_SIZE, drawY - TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY - TILE_SIZE, z);
    vertex(x + TILE_SIZE, drawY + TILE_SIZE, z);
    endShape();
    
  }
}
