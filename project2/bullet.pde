/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//missile class

//===========================================================================================
class bullet implements Serializable{
  
  //----------------------------------------------
  //bullet variables
  PVector pos, vel;
  int radius = 15, bOrF;
  boolean dead = false;
  //----------------------------------------------
  
  //----------------------------------------------
  //contructor
  bullet(PVector xy, int i) {
    pos = xy.copy();
    vel = new PVector(0, -10);
    bOrF = i;
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //display banana or F based on character
  void display() {
    if(bOrF == 0) {
      displayBanana(int(pos.x), int(pos.y));
    } else {
      displayF(int(pos.x), int(pos.y));
    }
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //update position
  void run() {
    display();
    pos.add(vel);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //bullet states and interations
  //----------------------------------------------
  boolean isDead() {
    if(pos.y < 0) return true;
    else return dead;
  }
  //----------------------------------------------
  void kill() {
    dead = true;
  }
  //----------------------------------------------
  boolean hit(enemy e) {
    float d = sqrt(pow(e.pos.x - this.pos.x, 2) + pow(e.pos.y - this.pos.y, 2));
    if(d <= this.radius + e.radius) return true;
    else return false;
  }
  //----------------------------------------------
  
}//end missile class
//===========================================================================================
