---
layout: page
title: About
permalink: /about/
comments: true
---

**Nolan (kinda) knows how to code.**

- Born: December 2008, San Diego
- Lives in: San Diego
- Age: <span id="age"></span> seconds

Interests:

- NodeJS
- Running (XC & Track) 👟
- APIs & Problem Solving

Cool things I've done:

- I've gone on a road trip for a year around the US (I've been to all the states except Alaska)
- I made a Duolingo API wrapper (for NodeJS 💪)

Things I have yet to do:

- Figure out the theme switcher for Jekyll
- Figure out Jekyll

{% include game.html gamename="Dino_Bros" %}

**MAP OF MY YEAR LONG TRIP:**
<img src="../images/map.jpg" alt="tripmap">

<script>
function calculateAge() {
    const birthDate = new Date('2008-12-19');
    const now = new Date();
    const ageInMilliseconds = now - birthDate;
    const ageInSeconds = Math.floor(ageInMilliseconds / 1000);

    const years = Math.floor(ageInSeconds / (365 * 24 * 60 * 60));
    const days = Math.floor((ageInSeconds % (365 * 24 * 60 * 60)) / (24 * 60 * 60));
    const hours = Math.floor((ageInSeconds % (24 * 60 * 60)) / (60 * 60));
    const minutes = Math.floor((ageInSeconds % (60 * 60)) / 60);
    const seconds = ageInSeconds % 60;

    return `${years}:${days - (years * 365)}:${hours}:${minutes}:${seconds}`;
}

function updateAge() {
  document.getElementById('age').textContent = calculateAge();
}

updateAge();
setInterval(updateAge, 1000);
</script>
