class Obstacle 
{
  float x;
  int type;
  Obstacle(float x, int type) 
  {
    this.x = x;
    this.type = type;
  }
  void update() 
  {
  }
  void display() 
  {
    if (type == 0) 
    {
      // rock
      fill(120);
      ellipse(x, 300, 40, 40);
    } else 
    {
      // hole
      fill(0);
      rect(x - 30, 320, 60, 80);
    }
  }
  boolean hit(float px, float py) 
  {
    // rock 
    if (type == 0) 
    {
      float d = dist(px, py, x, 300);
      if (d < 40) 
      {
        return true;
      }
    }
    // hole collision
    else 
    {
      if (px > x - 30 && px < x + 30 && py >= 300) 
      {
        return true;
      }
    }
    return false;
  }
}
