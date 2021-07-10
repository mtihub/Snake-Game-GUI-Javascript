int canvasWidth  = 400;
int canvasHeight = 400;
int squareSize   = 10;
int rows         = ceil(canvasHeight / squareSize);
int cols         = ceil(canvasWidth  / squareSize);
int lastKeyPress = -1;
int lastPressed = 0;
int whenPressed = 0;

Snake snake = new Snake(rows, cols, squareSize);
Food food   = new Food(rows, cols, squareSize);
int score = 0;

void draw() { 
  frameRate(20);
  background(1);
  
  textSize(14);
  text(Integer.toString(score), 360, 395);
  
  food.draw();
  snake.draw();
  
  // 0->nothing, 1->ate, 2->endgame
  int gameStatus = snake.update(food);
  if (gameStatus == 2) {
    stop();
    clear();
    text(("Game Over. Your Score: " + Integer.toString(score)), 110, 200);
  }
  else if (gameStatus == 1) {
    score++;
  }
}

void setup() {
  size(400, 400);
}

void keyPressed() {
  if (key == CODED) {
    whenPressed = millis();
    if (whenPressed-lastPressed > 1) {  // Disable double key press
      if (keyCode == UP && lastKeyPress != DOWN) {
        snake.goUp();
        lastKeyPress = keyCode;
        lastPressed = whenPressed;
      } 
      else if (keyCode == DOWN && lastKeyPress != UP) {
        snake.goDown();
        lastKeyPress = keyCode;
        lastPressed = whenPressed;
      } 
      else if (keyCode == LEFT && lastKeyPress != RIGHT) {
        snake.goLeft();
        lastKeyPress = keyCode;
        lastPressed = whenPressed;
      }
      else if (keyCode == RIGHT && lastKeyPress != LEFT) {
        snake.goRight();
        lastKeyPress = keyCode;
        lastPressed = whenPressed;
      }
    }
  } 
}

void keyReleased() {
  
}
