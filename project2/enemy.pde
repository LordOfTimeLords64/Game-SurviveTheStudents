/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//enemies class

//===========================================================================================
class enemy implements Serializable{
  
  //----------------------------------------------
  //enemy vars
  PVector pos, vel;
  int radius = 30, pIndex = floor(random(studentPics.length-0.01));
  boolean dead = false;
  //----------------------------------------------
  
  //----------------------------------------------
  //contructor
  enemy(PVector xy, PVector velocity) {
    pos = xy.copy();
    vel = velocity;
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //display enemy
  void display() {
    displayProfile(studentPics[pIndex], pos.x, pos.y);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //enemy motion and interating
  //----------------------------------------------
  void run() {
    display();
    pos.add(vel);
  }
  //----------------------------------------------
  boolean isDead() {
    return dead;
  }
  //----------------------------------------------
  boolean passed() {
    if(pos.y > height+radius) return true;
    else return false;
  }
  //----------------------------------------------
  void kill() {
    dead = true;
  }
  //----------------------------------------------
  
}//end enemy class
//===========================================================================================
