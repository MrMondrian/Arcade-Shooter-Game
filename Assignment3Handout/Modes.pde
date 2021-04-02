final char KEY_VIEW = 'r';

final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

final char KEY_BONUS = 'b';
final char KEY_TEX = 't';
final char KEY_COLLISION = 'c';

boolean doBonus = false;
boolean doTextures = false;
boolean doCollision = false;

boolean isOrtho = true;

void keyPressed()
{
}

void keyReleased() {
  if(key == KEY_VIEW)
  {
     if(isOrtho)
     {
       camera(1, 4, (0.5) / tan(PI*30.0 / 180.0), 1,3, 0, 0, 1, 0);
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
}
