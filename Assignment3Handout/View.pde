// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

void setPerspective()
{
   setPerpCamera();
   setPerpProj();
   isOrtho = false;
}

void setOrtho()
{
  setOrthoCamera();
  setOrthoProj();
  isOrtho = true;
}

void setPerpCamera()
{
   camera(0, 2, (1) / tan(PI*30.0 / 180.0), 0, 0.5, 0, 0, 1, 0);
}

void setPerpProj()
{
  frustum(-0.5, 0.5, -0.5, 0.5, 1, -1);
}

void setOrthoCamera()
{
   camera(0, 0, (0.5) / tan(PI*30.0 / 180.0), 0,0, 0, 0, 1, 0);
}

void setOrthoProj()
{
  ortho(-1,1,-1,1);
}
