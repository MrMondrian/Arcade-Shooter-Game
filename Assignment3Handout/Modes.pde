// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

final char KEY_VIEW = 'r';

final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

final char KEY_BONUS = 'b';
final char KEY_TEX = 't';
final char KEY_COLLISION = 'c';

final char MOVE_RIGHT = 'd';
final char MOVE_LEFT = 'a';
final char MOVE_UP = 'w';
final char MOVE_DOWN = 's';

boolean doBonus = false;
boolean doTextures = false;
boolean doCollision = false;

boolean isOrtho = true;

void keyPressed()
{
  if(key == KEY_VIEW)
  {
     if(doBonus)
     {
       startBonus();
     }
     else if(isOrtho)
     {
       setPerspective();
     }
     else
     {
        setOrtho();
     }
  }
  
  else if(key == KEY_SHOOT && player.alive)
  {
    objects.add(player.getBullet());
  }
  
  else if(key == MOVE_RIGHT)
  {
    right = true;
  }
  else if(key == MOVE_LEFT)
  {
    left = true;
  }
  else if(key == MOVE_DOWN)
  {
    down = true;
  }
  else if(key == MOVE_UP)
  {
    up = true;
  }
  
  else if(key == KEY_TEX)
  {
    doTextures = !doTextures;
  }
  
  else if(key == KEY_COLLISION)
    doCollision = !doCollision;
    
  else if(key == KEY_BONUS)
    doBonus = !doBonus;
    
}

void keyReleased() {
  if(key == MOVE_RIGHT)
  {
    right = false;
  }
  else if(key == MOVE_LEFT)
  {
    left = false;
  }
  else if(key == MOVE_DOWN)
  {
    down = false;
  }
  else if(key == MOVE_UP)
  {
    up = false;
  }
}
