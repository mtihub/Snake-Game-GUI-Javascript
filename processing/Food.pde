class Food {
  int rows;
  int cols;
  int squareSize;
  Position pos;
  int r;
  int increaseBy;
  boolean isIncreasing;
  
  Food(int _r, int _c, int _sz) {
    this.rows       = _r;
    this.cols       = _c;
    this.squareSize = _sz;
    
    this.r   = ceil(squareSize/2);
    this.increaseBy = 0;
    this.isIncreasing = true;
    //this.pos = new Position(0,0);
    this.pos = new Position((int)random(0, rows), (int)random(0, cols));
  }
  
  void update() {
    this.pos.updateX((int)random(0, rows));
    this.pos.updateY((int)random(0, cols));
  }
  
  void draw() {
    fill(244, 255, 102);
    if (isIncreasing) {
      increaseBy++;
      if (increaseBy >= 3) {
        isIncreasing = false;
      }
    }
    else {
      increaseBy--;
      if (increaseBy <= -3) {
        isIncreasing = true;
      }
    }
    ellipse((pos.getX()*squareSize) + r, (pos.getY()*squareSize) + r, r+increaseBy, r+increaseBy);
  }
  
  Position getPosition() {
    return this.pos;
  }
  
  int getX() {
    return this.pos.getX();
  }
  
  int getY() {
    return this.pos.getY();
  }
}
