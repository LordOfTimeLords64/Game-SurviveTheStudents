/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//enemies list class

//===========================================================================================
class enemies implements Serializable{
  ArrayList<enemy> enemies;
  int passed = 0;
  
  //----------------------------------------------
  //startup
  enemies() {
    enemies = new ArrayList<enemy>();
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //adding enemies to the list
  void addEnemy(PVector xy, PVector velocity) {
    enemies.add(new enemy(xy, velocity));
  }//----------------------------------------------
  
  //----------------------------------------------
  //enemies motion
  void run() {
    for(int i = enemies.size() - 1; i >= 0; i--) {
      enemy e = enemies.get(i);
      e.run();
      
      if(e.passed()) {
        e.kill();
        passed++;
        playSad();
      }
      
      if(e.isDead()) {
        enemies.remove(i);
      }
    }
  }
  //----------------------------------------------
  
}//end enemies list class
//===========================================================================================
