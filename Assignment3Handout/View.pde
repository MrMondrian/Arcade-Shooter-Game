void setPerspective()
{
   camera(1, 2.5, (0.5) / tan(PI*30.0 / 180.0), 1, 1.5, 0, 0, 1, 0);
   frustum(-0.5, 0.5, -0.5, 0.5, 1, -1);
   isOrtho = false;
}

void setOrtho()
{
  camera(1, 1, (0.5) / tan(PI*30.0 / 180.0), 1,1, 0, 0, 1, 0);
  ortho(-1,1,-1,1);
  isOrtho = true;
}
