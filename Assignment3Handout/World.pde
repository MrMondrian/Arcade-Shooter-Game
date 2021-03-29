final float TILE_SIZE = 20;
final int WORLD_SIZE = 256;

class WorldSection
{
  Tile[] tiles;
  
  float x;
  float y;
  
  public WorldSection(float _x, float _y)
  {
    x = _x;
    y = _y;
    tiles = new Tile[WORLD_SIZE];
    int k = 0;
    for(float j = 20; j < 640; j += 2 * TILE_SIZE)
    {
      for(float i = TILE_SIZE; i < 640; i += 2*TILE_SIZE)
      {
        Tile t = new Tile(i, j);
        tiles[k] = t;
        k++;
      }
    }
  }
  
  public void print()
  {
    pushMatrix();
    y++;
    translate(x,y);
    for(int i = 0; i < tiles.length; i++)
      tiles[i].print();
    popMatrix();
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
    c = color(random(0,1), random(0,1), random(0,1));
  }
  
  public void print()
  {
    fill(c);
    vertex(x - TILE_SIZE, y + TILE_SIZE);
    vertex(x - TILE_SIZE, y - TILE_SIZE);
    vertex(x + TILE_SIZE, y + TILE_SIZE);
    
    vertex(x - TILE_SIZE, y - TILE_SIZE);
    vertex(x + TILE_SIZE, y - TILE_SIZE);
    vertex(x + TILE_SIZE, y + TILE_SIZE);
  }
}
