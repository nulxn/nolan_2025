---
layout: base
title: Nolan's Portfolio
description: Nolan's main webpage
author: Nolan Hightower
image: /images/mario_animation.png
hide: true
---

<!-- Liquid:  statements -->

<!-- Include submenu from _includes to top of pages -->

<!--- Concatenation of site URL to frontmatter image  --->

{% assign sprite_file = site.baseurl | append: page.image %}

<!--- Has is a list variable containing mario metadata for sprite --->

{% assign hash = site.data.mario_metadata %}

<!--- Size width/height of Sprit images --->

{% assign pixels = 256 %}

<!--- HTML for page contains <p> tag named "Mario" and class properties for a "sprite"  -->

<p id="mario" class="sprite"></p>
  
<!--- Embedded Cascading Style Sheet (CSS) rules, 
        define how HTML elements look 
--->
<style>
.sprite {
height: {{pixels}}px;
width: {{pixels}}px;
background-image: url('{{sprite_file}}');
background-repeat: no-repeat;
}

#mario {
background-position: calc({{animations[0].col}} _ {{pixels}} _ -1px) calc({{animations[0].row}} _ {{pixels}}_ -1px);
}
</style>

<!--- Embedded executable code--->
<script>
  ////////// convert YML hash to javascript key:value objects /////////

  var mario_metadata = {}; //key, value object
  {% for key in hash %}  
  
  var key = "{{key | first}}"  //key
  var values = {} //values object
  values["row"] = {{key.row}}
  values["col"] = {{key.col}}
  values["frames"] = {{key.frames}}
  mario_metadata[key] = values; //key with values added

  {% endfor %}

  ////////// game object for player /////////

  class Mario {
    constructor(meta_data) {
      this.tID = null;  //capture setInterval() task ID
      this.positionX = 0;  // current position of sprite in X direction
      this.currentSpeed = 0;
      this.marioElement = document.getElementById("mario"); //HTML element of sprite
      this.pixels = {{pixels}}; //pixel offset of images in the sprite, set by liquid constant
      this.interval = 100; //animation time interval
      this.obj = meta_data;
      this.marioElement.style.position = "absolute";
    }

    animate(obj, speed) {
      let frame = 0;
      const row = obj.row * this.pixels;
      this.currentSpeed = speed;

      this.tID = setInterval(() => {
        const col = (frame + obj.col) * this.pixels;
        this.marioElement.style.backgroundPosition = `-${col}px -${row}px`;
        this.marioElement.style.left = `${this.positionX}px`;

        this.positionX += speed;
        frame = (frame + 1) % obj.frames;

        const viewportWidth = window.innerWidth;
        if (this.positionX > viewportWidth - this.pixels) {
          document.documentElement.scrollLeft = this.positionX - viewportWidth + this.pixels;
        }
      }, this.interval);
    }

    startWalking() {
      this.stopAnimate();
      this.animate(this.obj["Walk"], 3);
    }

    startRunning() {
      this.stopAnimate();
      this.animate(this.obj["Run1"], 6);
    }

    startPuffing() {
      this.stopAnimate();
      this.animate(this.obj["Puff"], 0);
    }

    startCheering() {
      this.stopAnimate();
      this.animate(this.obj["Cheer"], 0);
    }

    startFlipping() {
      this.stopAnimate();
      this.animate(this.obj["Flip"], 0);
    }

    startResting() {
      this.stopAnimate();
      this.animate(this.obj["Rest"], 0);
    }

    stopAnimate() {
      clearInterval(this.tID);
    }
  }

  const mario = new Mario(mario_metadata);

  ////////// event control /////////

  window.addEventListener("keydown", (event) => {
    if (event.key === "ArrowRight") {
      event.preventDefault();
      if (event.repeat) {
        mario.startCheering();
      } else {
        if (mario.currentSpeed === 0) {
          mario.startWalking();
        } else if (mario.currentSpeed === 3) {
          mario.startRunning();
        }
      }
    } else if (event.key === "ArrowLeft") {
      event.preventDefault();
      if (event.repeat) {
        mario.stopAnimate();
      } else {
        mario.startPuffing();
      }
    }
  });

  //touch events that enable animations
  window.addEventListener("touchstart", (event) => {
    event.preventDefault(); // prevent default browser action
    if (event.touches[0].clientX > window.innerWidth / 2) {
      // move right
      if (currentSpeed === 0) { // if at rest, go to walking
        mario.startWalking();
      } else if (currentSpeed === 3) { // if walking, go to running
        mario.startRunning();
      }
    } else {
      // move left
      mario.startPuffing();
    }
  });

  //stop animation on window blur
  window.addEventListener("blur", () => {
    mario.stopAnimate();
  });

  //start animation on window focus
  window.addEventListener("focus", () => {
     mario.startFlipping();
  });

  //start animation on page load or page refresh
  document.addEventListener("DOMContentLoaded", () => {
    // adjust sprite size for high pixel density devices
    const scale = window.devicePixelRatio;
    const sprite = document.querySelector(".sprite");
    sprite.style.transform = `scale(${0.2 * scale})`;
    mario.startResting();
  });

</script>

# Home

[**BRAINROT**](skibidbiden)

**MY FIRST DAYS PAGE IS ON THE BUTTONS**

## Nolan's Notes

1. I didn't do all the hacks in order, so the links to them are scattered around.
2. I imported my own theme from another Jekyll website (andrewhwanpark/dark-poole) and made changes to certain things, including the footer and navbar GIFs.
3. Please don't judge my photography since I just imported all my photos from Lightroom.

## HTML Hacks (Image + Table\[submenu\])

<img src="images/image.gif" alt="This is an image">

| [Javascript Cell](posts/js) | [About](about) | [Python Hacks](posts/py-hacks) | [Attempted vs Accomplishment](posts/what) |

## (Some) Javascript Hacks

* [ITunes API + JS/HTML Output](posts/itunes)
* [Calculator](calculator)

I put my Javascript cell (my person object) in the table below.

<div>
  <button style='color:white;' onclick="swapTheStuff()">swap the links</button>
</div>
<div>
<button id="btn1"><a href="firstdays/">first days</a></button>
<br />
<button id="btn2"><a href="about/">about</a></button>
</div>

As for if getting Google Snake is considered being lazy, I would like to note that Google has the site disabled for IFrame so I couldn't just add it to my site. I instead got the code and added it to a new folder called games/ and added a game.html (expansion wip, this means u can choose dif games based on way of import) so I can add it to any site I want. I also made it so using the arrow keys doesn't move the site up in down by comminicating to the parent site with JS and eventListeners.

This took probably more problem solving and critical thinking that just copying the snake code that you provided, but idk 🤷

{% include game.html %}

### Mr Brown Clicker

<div>
   <img id="mrbrown" alt="mrbown" width="500px" height="500px" src="images/map.jpg">
   <p id="score">Score: Click to start!</p>
</div>
<script>
   const msg = "Score: ";
   const stationary = "images/map.jpg";
   const img1 = "images/image.png";
   const img2 = "images/mario_animation.png";
   const scoreElement = document.getElementById("score");
   const clickSound = document.getElementById("clickSound");
   var mrbrown = document.getElementById("mrbrown");
   let score = -1;
   let lastClickTime = null;
   function updateScore() {
     score++;
     scoreElement.textContent = msg + score;
   }
   function swapImg() {
     if (mrbrown.src.includes(stationary)) {
       console.log("station -> img1")
       mrbrown.src = img1;
     } else if (mrbrown.src.includes(img1)) {
       console.log("making it img2, from img1")
       mrbrown.src = img2;
     } else {
       console.log("else")
       mrbrown.src = img1;
     }
   }
  function playSound() {
    const currentTime = Date.now();
    lastClickTime = currentTime;
    if (score > 0) {
      if (lastClickTime) {
        const timeDiff = currentTime - lastClickTime;
        const playbackRate = Math.max(1, Math.min(3, 1000 / timeDiff)); 
        clickSound.playbackRate = playbackRate;
      } else {
        clickSound.playbackRate = 1; 
      }
      clickSound.currentTime = 0; 
      clickSound.play(); 
      lastClickTime = currentTime; 
     }
   }
   mrbrown.addEventListener("click", function () {
     updateScore();
     swapImg();
     playSound();
   })
</script>

<script>
function swapTheStuff() {
var btn1 = document.getElementById('btn1');
var btn2 = document.getElementById('btn2');
var link1 = 'firstdays/';
var link2 = 'about/';
function getCode(li, na){
  return `<a href="${li}">${na}</a>`;
}
if(btn1.innerHTML === getCode(link1, "first days")) {
  btn1.innerHTML = getCode(link2, "about");
  btn2.innerHTML = getCode(link1, "first days");
} else {
    btn2.innerHTML = getCode(link2, "about");
    btn1.innerHTML = getCode(link1, "first days");
}
}
</script>
