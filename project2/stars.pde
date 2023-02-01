/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//stars list class

//===========================================================================================
class stars implements Serializable{
  ArrayList<star> stars;
  
  //----------------------------------------------
  //initialize
  stars() {
    stars = new ArrayList<star>();
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //add stars to list
  void addStar(PVector xy, PVector velocity) {
    stars.add(new star(xy, velocity));
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //stars motion
  void run() {
    for(int i = stars.size() - 1; i >= 0; i--) {
      star s = stars.get(i);
      s.run();
      
      if(s.passed()) {
        s.kill();
      }
      
      if(s.isDead()) {
        stars.remove(i);
        addStar(new PVector(random(5, width-5), -20), new PVector(0, random(1, 2)));
      }
    }
  }
  //----------------------------------------------
  
}//end star list class
//===========================================================================================
