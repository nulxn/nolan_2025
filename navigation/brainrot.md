---
layout: page
title: Brainrot
permalink: skibidbiden
---

 <audio id="audioPlayer" controls>
    <source src="assets/dawg.mp3" type="audio/mpeg">
    Browser is bad (audio)
</audio>

<video id="videoPlayer" controls width="600">
    <source src="assets/Video-776.mp4" type="video/mp4">
    Browser is bad (vid)
</video>

<script>
document.addEventListener('DOMContentLoaded', (event) => {
   const videoPlayer = document.getElementById('videoPlayer');

   const audioPlayer = document.getElementById('audioPlayer');

   audioPlayer.play().catch(error => {
      console.log('Audio playback failed:', error);
   });
   videoPlayer.play().catch(error => {
      console.log('Error playing video:', error);
   });

   videoPlayer.addEventListener('ended', () => {
      console.log('Video has ended.');
   });
});
</script>
