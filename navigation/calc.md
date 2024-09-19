---
layout: page
title: Calculator
permalink: calculator/
---

**Technically, u shouldn't use eval() cuz it's dangerous and can cause back doors, but i trust mr brown and mr mort 😊**

<style>
  .device {
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f4f4f4;
  }
  #clear {
    background-color: orange !important;
  }
  .calculator {
    border: 1px solid #ccc !important;
    border-radius: 10px;
    padding: 20px;
    background: white;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  }
  input[type="text"] {
    width: 100%;
    height: 40px;
    font-size: 20px;
    text-align: right;
    margin-bottom: 10px;
  }
  button {
    width: 23%;
    height: 40px;
    font-size: 20px;
    margin: 1%;
    cursor: pointer;
  }
</style>
<div class="device">
  <div class="calculator">
    <input type="text" id="display" disabled />
    <div>
      <button id="clear" onclick="clearDisplay()">C</button>
      <button onclick="appendToDisplay('7')">7</button>
      <button onclick="appendToDisplay('8')">8</button>
      <button onclick="appendToDisplay('9')">9</button>
      <button onclick="appendToDisplay('/')">/</button>
    </div>
    <div>
      <button onclick="appendToDisplay('4')">4</button>
      <button onclick="appendToDisplay('5')">5</button>
      <button onclick="appendToDisplay('6')">6</button>
      <button onclick="appendToDisplay('*')">*</button>
    </div>
    <div>
      <button onclick="appendToDisplay('1')">1</button>
      <button onclick="appendToDisplay('2')">2</button>
      <button onclick="appendToDisplay('3')">3</button>
      <button onclick="appendToDisplay('-')">-</button>
    </div>
    <div>
      <button onclick="appendToDisplay('0')">0</button>
      <button onclick="calculateResult()">=</button>
      <button onclick="appendToDisplay('+')">+</button>
    </div>
  </div>

  <script>
    function appendToDisplay(value) {
      document.getElementById("display").value += value;
    }

    function clearDisplay() {
      document.getElementById("display").value = "";
    }

    function calculateResult() {
      const display = document.getElementById("display");
      display.value = eval(display.value);
    }
  </script>
</div>
