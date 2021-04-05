class KeyFrame
{
  PVector start;
  PVector end;
  
  float begin;
  float time;
  
  public KeyFrame(PVector s, PVector e, float b, float t)
  {
    start = s;
    end  = e;
    begin = b;
    time = t;
  }
  
  PVector getPosition()
  {
    float t = (System.nanoTime() - begin) / time;
    float t1;
    if(t < 0.5)
    {
      t1 = 1 - cos(t * PI/2.0);
    }
    else
    {
      t1 = sin(t * PI/2.0);
    }
    
    return lerpVectors(t1);
  }
  
  PVector lerpVectors(float t)
  {
    float x = _myLerp(start.x, end.x, t);
    float y = _myLerp(start.y, end.y, t);
    return new PVector(x,y);
  }
  
  boolean finished()
  {
    return System.nanoTime() - begin >= time;
  }
}



float _myLerp(float a, float b, float t)
{
  return (t - 1)*a + t*b;
}
