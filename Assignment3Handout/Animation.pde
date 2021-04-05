class KeyFrame
{
  PVector start;
  PVector end;
  
  float begin;
  float elapsed;
  
  public KeyFrame(PVector s, PVector e, float b, float el)
  {
    start = s;
    end  = e;
    begin = b;
    elapsed = el;
  }
  
  PVector getPosition()
  {
    float t = (System.nanoTime() - begin) / elapsed;
    t *= 2;
    float t1;
    if(t < 1)
    {
      t1 = (1 - cos(t * PI/2.0)) / 2.0;
    }
    else
    {
      t1 = 0.5 +  (sin((t-1) * PI/2.0)) /2.0;
    }
  
    
    return lerpVectors(t1);
  }
  
  PVector lerpVectors(float t)
  {
    float x = _myLerp(start.x, end.x, t);
    float y = _myLerp(start.y, end.y, t);
    return new PVector(x,y, PERSON_Z);
  }
  
  boolean finished()
  {
    return System.nanoTime() - begin >=elapsed;
  }
}



float _myLerp(float a, float b, float t)
{
  return (1 - t)*a + t*b;
}
