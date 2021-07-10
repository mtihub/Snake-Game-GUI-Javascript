class Snake {
  int rows;
  int cols;
  int squareSize;
  
  int vel;
  int xVel;
  int yVel;

  int blockSize;
  int blockGap;
  ArrayList<Position> blocks;
  
  Snake(int _r, int _c, int _sz) {
    this.rows       = _r;
    this.cols       = _c;
    this.squareSize = _sz;
    
    this.vel  = 1;
    this.xVel = vel;
    this.yVel = 0;
    
    this.blockSize = squareSize;
    this.blockGap  = 0;   
    
    this.blocks = new ArrayList<Position>();
    this.blocks.add(new Position(2,0));
    this.blocks.add(new Position(1,0));
    this.blocks.add(new Position(0,0));
  }
  
  void goUp() {
    this.xVel = 0;
    this.yVel = -vel;
  }
  
  void goDown() {
   this.xVel = 0;
   this.yVel = vel;
  }
  
  void goLeft() {
    this.xVel = -vel;
    this.yVel = 0;
  }
  
  void goRight() {
    this.xVel = vel;
    this.yVel = 0;
  }
  
  boolean checkBoundary(Position pos) {
    if (pos.getX() >= rows && xVel > 0) {
      pos.updateX(0);
      return true;
    }
    else if (pos.getX() < 0 && xVel < 0) {
      pos.updateX(rows-1);
      return true;
    }
    if (pos.getY() < 0 && yVel < 0) {
      pos.updateY(cols-1);
      return true;
    }
    else if (pos.getY() >= cols && yVel > 0) {
      pos.updateY(0);
      return true;
    }
    return false;
  }
  
  boolean checkCollision(Position pos) {
    for (Position blockPos : blocks) {
      if (blockPos.getX() == pos.getX() && blockPos.getY() == pos.getY()) {
        return true;
      }
    }
    return false;
  }
  
  // 0->nothing, 1->ate, 2->endgame
  int update(Food food) {
    boolean hasEaten = false;
    Position prevPos = new Position(0,0);
    Position newPos  = new Position(blocks.get(0));
    newPos.incrementXY(xVel, yVel);
    checkBoundary(newPos);
    
    if (checkCollision(newPos)) {
      //blocks.clear();
      return 2;
    }
    
    for (Position pos : blocks) {
      prevPos.updateXY(pos.getX(), pos.getY());
      pos.updateXY(newPos.getX(), newPos.getY());
      newPos.updateXY(prevPos.getX(), prevPos.getY());
      
      if (pos.getX() == food.getX() && pos.getY() == food.getY()) {
        hasEaten = true;
      }
    }
    
    if (hasEaten) {
      checkBoundary(prevPos);
      this.blocks.add(prevPos);
      food.update();
      while (true) {
        for (Position pos : blocks) {
          if (pos.getX() == food.getX() && pos.getY() == food.getY()) {
            food.update();
            continue;
          }
        }
        break;
      }
      return 1;
    }
    
    return 0;
  }
  
  void draw() {
    fill(255);
    noStroke();
    for (Position pos : blocks) {
      rect(pos.getX()*squareSize, pos.getY()*squareSize, blockSize-blockGap, blockSize);
    } 
  }
  
}
