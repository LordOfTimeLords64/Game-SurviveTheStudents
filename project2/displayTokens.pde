/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
// Displaying profiles and teacher projectiles

//===================================================================================
void displayProfile(PImage img, float cX, float cY){
  
  //starting corner coords and radius
  int x0 = round(cX-img.width/2);
  int y0 = round(cY-img.height/2);
  float radius = min(img.width/2, img.height/2);
  
  //check each pixel and set color if proper
  for(int x = x0; x < x0+img.width; x++) {
      for(int y = y0; y < y0+img.height; y++) {
        float dx = x-cX;
        float dy = y-cY;
        if( sqrt(dx*dx + dy*dy) <= radius){
         set(x, y, img.get(x-x0, y-y0));
        }
      }
    }
    
}//end display profile
//===================================================================================


//===================================================================================
void displayF(int cX, int cY){
  
  //starting corner coords
  int x0 = round(cX-F.width/2);
  int y0 = round(cY-F.height/2);
  
  //check each pixel and set color if proper
  for(int x = x0; x < x0+F.width; x++) {
      for(int y = y0; y < y0+F.height; y++) {
        color c = F.get(x-x0, y-y0);
        if( red(c)>blue(c) && red(c)>green(c) ){ set(x,y, c); }
      }
    }
    
}//end display F
//===================================================================================


//===================================================================================
void displayBanana(int cX, int cY){
  
  //starting corner coords
  int x0 = round(cX-B.width/2);
  int y0 = round(cY-B.height/2);
  
  //check each pixel and set color if proper
  for(int x = x0; x < x0+B.width; x++) {
      for(int y = y0; y < y0+B.height; y++) {
        color c = B.get(x-x0, y-y0);
        int intensity = round((red(c)+green(c)+blue(c))/3);
        if( (red(c)>blue(c) && green(c)>blue(c)) || intensity>250 ){set(x,y, c);}
      }
    }
}//end display Banana
//===================================================================================
