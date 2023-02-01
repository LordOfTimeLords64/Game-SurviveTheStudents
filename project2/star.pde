/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//star class

//===========================================================================================
class star implements Serializable{
  
  //----------------------------------------------
  // star vars
  PVector pos, vel;
  int radius = round(random(1, 6));
  boolean dead = false;
  //----------------------------------------------
  
  //----------------------------------------------
  //constructor
  star(PVector xy, PVector velocity) {
    pos = xy.copy();
    vel = velocity;
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //display star
  void display() {
    ellipseMode(CENTER);
    fill(255);
    circle(pos.x, pos.y, radius*2);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //move star
  void run() {
    display();
    pos.add(vel);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //removing stars past border
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
  
}//end star class
//===========================================================================================
