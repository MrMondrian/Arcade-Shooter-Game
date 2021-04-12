// Anthony Tan 7882272
// April 16 2021
// COMP 3490 A3
// :)

//this class represents a key frame. It has a start position and an end position
//upon calling getPosition, it will return the current position based on the current time
class KeyFrame
{
  PVector start; //starting position
  PVector end; //ending position
  
  float begin; //start time
  float elapsed; //length of the movement
  
  public KeyFrame(PVector s, PVector e, float b, float el)
  {
    start = s;
    end  = e;
    begin = b;
    elapsed = el;
  }
  
  PVector getPosition()
  {
    //get t
    float t = (System.nanoTime() - begin) / elapsed;
    
    //make it ease in/out
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
  
  //lerps two vectors based on the input t using a helper function
  PVector lerpVectors(float t)
  {
    float x = _myLerp(start.x, end.x, t);
    float y = _myLerp(start.y, end.y, t);
    return new PVector(x,y, start.z);
  }
  
  boolean finished()
  {
    return System.nanoTime() - begin >=elapsed;
  }
}

//simple lerp function
//kept it out of the key frame class in case another class needs it
float _myLerp(float a, float b, float t)
{
  return (1 - t)*a + t*b;
}
