import processing.sound.*;//load voive model//learn google
AudioIn mic;//micphone
Amplitude amp; // check variable

float chickX = 100;
float chickY = 300;
float groundY = 320;

float velocityY = 0;//jump speed

boolean jumping = false;

ArrayList<Obstacle> obstacles; //object list
int score = 0;
boolean gameOver = false;

void setup() 
{
  size(800, 400);
  // sound setup
  mic = new AudioIn(this, 0);//the voice
  mic.start();
  amp = new Amplitude(this);//mac
  amp.input(mic);
  obstacles = new ArrayList<Obstacle>();//create
  // create first  5 obstacles
  for (int i = 0; i < 5; i++) 
  {
    float x = 600 + i * 300;
    int type = int(random(2)); // 0 = rock, 1 = hole
    obstacles.add(new Obstacle(x, type));//add to list//91
  }
}

void draw() 
{
  background(135, 206, 235);
  // grass
  fill(100, 200, 100);
  rect(0, groundY, width, 80);
  // sound level
  float level = amp.analyze() * 500;//
  fill(0);
  textSize(16);
  text("Sound Level: " + int(level), 20, 30);
  text("Score: " + score, 20, 55);
  if (gameOver) 
  {
    fill(255, 0, 0);
    textSize(40);
    text("GAME OVER", 250, 180);
    textSize(20);
    text("Press R to Restart", 300, 220);
    return;
  }
  // WALK using sound above 10
  if (level > 10) 
  {
    chickX += 3;
  }
  // JUMP using sound above 50
  if (level > 50 && !jumping) 
  {
    velocityY = -12;//up
    jumping = true;
  }
  // gravity
  velocityY += 0.6;
  chickY += velocityY;
  // land
  if (chickY >= 300) 
  {
    chickY = 300;
    velocityY = 0;
    jumping = false;
  }
  if (chickX > 200) 
  {
      float moveAmount = chickX - 200;
      chickX = 200;
     for (int i = 0; i < obstacles.size(); i++) 
     {
        obstacles.get(i).x -= moveAmount;//chik X move
     }
      score += int(moveAmount);
  }
  // draw chick
  drawChick();
  // obstacles
  for (int i = 0; i < obstacles.size(); i++) 
  {
    obstacles.get(i).display();//do other tab
    if (obstacles.get(i).hit(chickX, chickY)) //other tab
    {
      gameOver = true;
    }
  }
  // add new obstacles endlessly
  if (obstacles.get(obstacles.size()-1).x < width) //if the last thing in the screen 
  {
    float newX = obstacles.get(obstacles.size()-1).x + random(250, 400);//lerning
    int type = int(random(2));
    obstacles.add(new Obstacle(newX, type));//add the sixth thing in the list
  }
}
void drawChick() 
{
  // body
  fill(255, 255, 0);
  ellipse(chickX, chickY, 50, 50);
  // eye
  fill(0);
  ellipse(chickX + 10, chickY - 5, 5, 5);
  // beak
  fill(255, 150, 0);
  triangle(chickX + 20, chickY,chickX + 30, chickY + 5,chickX + 20, chickY + 10);
  // legs
  stroke(255, 150, 0);
  line(chickX - 10, chickY + 25, chickX - 10, chickY + 35);
  line(chickX + 10, chickY + 25, chickX + 10, chickY + 35);
  noStroke();
}

void keyPressed() 
{
  if (key == 'r' || key == 'R') 
  {
    restartGame();
  }
}

void restartGame() 
{
  chickX = 100;
  chickY = 300;
  velocityY = 0;
  jumping = false;
  score = 0;
  gameOver = false;
  obstacles.clear();
  for (int i = 0; i < 5; i++) 
  {
    float x = 600 + i * 300;
    int type = int(random(2));
    obstacles.add(new Obstacle(x, type));
  }
}
