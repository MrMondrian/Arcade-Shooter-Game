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
     if(isOrtho)
     {
       camera(1, 2.5, (0.5) / tan(PI*30.0 / 180.0), 1, 1.5, 0, 0, 1, 0);
       frustum(-0.5, 0.5, -0.5, 0.5, 1, -1);
       isOrtho = false;
     }
     else
     {
        camera(1, 1, (0.5) / tan(PI*30.0 / 180.0), 1,1, 0, 0, 1, 0);
        ortho(-1,1,-1,1);
        isOrtho = true;
     }
  }
  
  if(key == MOVE_RIGHT)
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
