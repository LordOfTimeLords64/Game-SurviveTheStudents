/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//button class

//===========================================================================================
class button  implements Serializable{
  
  //----------------------------------------------
  //button vars
  int x, y, w, h;
  String words;
  //----------------------------------------------
  
  //----------------------------------------------
  //constructor
  button(int xPos, int yPos, int wth, int hth, String stuff) {
    x = xPos;
    y = yPos;
    w = wth;
    h = hth;
    words = stuff;
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //color updates and redrawing
  void run() {
    if(isHovered()) fill(0, 0, 140);
    else fill(0, 0, 190);
    rectMode(CENTER);
    rect(x, y, w, h);
    textSize(int(.75*h));
    fill(255);
    text(words, x, y-5);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //checking if mouse is on button
  boolean isHovered() {
    if(mouseX >= x-w/2 && mouseX <= x+w/2 && mouseY >= y-h/2 && mouseY <= y+h/2) {
      return true;
    } else {
      return false;
    }
  }
  //----------------------------------------------
  
}//end button class
//===========================================================================================
