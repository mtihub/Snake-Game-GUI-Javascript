class Position {
  int x;
  int y;
  Position(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  }
  Position(Position _pos) {
    this.x = _pos.getX();
    this.y = _pos.getY();
  }
  
  void incrementXY(int _x, int _y) {
    this.x += _x;
    this.y += _y;
  }
  
  void updateXY(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  } 
  
  void updateX(int _x) {
    this.x = _x;
  }
  
  void updateY(int _y) {
    this.y = _y;
  }
  
  int getX() {
    return this.x;
  }
  
  int getY() {
    return this.y;
  }
}
