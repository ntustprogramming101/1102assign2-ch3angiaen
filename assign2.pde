PImage bg, soil, life, soldier, cabbage;
PImage title, startNormal, startHovered;
PImage gameover, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int state = GAME_START;

int soilderDeep = floor(random(3)) + 3 ;
int soilderX = -50;
int soilderSpeed = 3;

int cabbageX =(floor(random(7)))*80;
int cabbageY =(floor(random(3))+2)*80;
boolean cabbagegrow = true;

int lifeState = 2;
int heartFirst = 10;
int heartPlus = 70;

int groundhogMove;
int groundhogX = 320;
int groundhogY = 80;
int groundhogNewX, groundhogNewY;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
  size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
}

void draw() {
    switch (state){
    case GAME_START:
        image(title, 0,0);
        image(startNormal, 248,360);
        if (mouseX > 248 && mouseX < 392
            && mouseY > 360 && mouseY < 420){
          image(startHovered, 248,360);
          if (mousePressed){
            state = GAME_RUN;
          }
        }
      break;
      
    case GAME_RUN:
        // set up background
        image(bg, 0, 0);
        image(soil, 0, 160);
        
        // draw the sun and grass
        colorMode(RGB);
        noStroke();
        fill(124, 204, 25);
        rectMode(CORNERS);
        rect(0, 145, width, 160);  
  
        stroke(255, 255, 0);
        strokeWeight(5);
        fill(253, 184, 19);
        ellipse(width-50, 50, 120, 120);
        
        // show the groundhog
        image(groundhogIdle ,groundhogX, groundhogY);
        
        // set up the running motion of soldier
        soilderX += soilderSpeed;
        image(soldier, soilderX, soilderDeep*80);
        if (soilderX > 640){
          soilderX = -50;
          soilderDeep = floor(random(3)) + 2 ;
        }
        
        if (soilderX < groundhogX+80 && soilderX+80 > groundhogX &&
            (soilderDeep*80) < groundhogY+80 && (soilderDeep*80)+80 > groundhogY){
          lifeState --;
          groundhogX = 320;
          groundhogY = 80;
            }
        
        // check the lifestate
        if (cabbagegrow){
          image(cabbage, cabbageX, cabbageY);
          if (cabbageX < groundhogX+80 && cabbageX+80 > groundhogX &&
              cabbageY < groundhogY+80 && (cabbageY)+80 > groundhogY){
            cabbagegrow = false;
          }
        }else{
            lifeState ++;
            cabbageX =(floor(random(7)))*80;
            cabbageY =(floor(random(3))+2)*80;
            cabbagegrow = true;
         }

        // check the lifestate
         if (lifeState == 0){
            state = GAME_LOSE;
             }
         if (lifeState == 1){
           image(life, heartFirst,10);
             }
         if (lifeState == 2){
           image(life, heartFirst,10);
           image(life, heartFirst+(heartPlus)*1,10);
             }
         if (lifeState > 2){
           image(life, heartFirst,10);
           image(life, heartFirst+(heartPlus)*1,10);
           image(life, heartFirst+(heartPlus)*2,10);
           lifeState = 3;
             }

      break;

    case GAME_LOSE:
        image(gameover, 0,0);
        image(restartNormal, 248,360);
        if (mouseX > 248 && mouseX < 392 &&
            mouseY > 360 && mouseY < 420){
          image(restartHovered, 248,360);
          if (mousePressed){
            state = GAME_RUN;
            lifeState = 2;
            groundhogX = 320;
            groundhogY = 80;
            soilderX = -50;
            soilderSpeed = 5;
          }
        }
      break;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = true;
        if (upPressed){
          if (groundhogY > 80){
            groundhogY -= 80;
          }
          upPressed = false;
        }
        
        break;
        
      case DOWN:
        downPressed = true;
        if (downPressed){
          if (groundhogY < 400){
          groundhogY += 80;
          }
          leftPressed = false;
        }
        
        break;
        
      case LEFT:
        leftPressed = true;
        if (leftPressed){
          if (groundhogX > 0){
          groundhogX -= 80;
          }
          leftPressed = false;
        }
        
        break;
        
      case RIGHT:
        rightPressed = true;
        if (rightPressed){
          if (groundhogX < 560){
          groundhogX += 80;
          }
          rightPressed = false;
        }
        
        break;
        
    }
  }
}
