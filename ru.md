# Tri 2 Retrospective

## 5 Things over 12 Weeks
1. Learn how to make a **full-stack application** and use Flask on Python
2. Learn how **agile methodology** works and how the workflows of projects work
3. Learn how to write pull requests and about how the **git workflow works (PRs, git rebase, conflicts)**
4. Worked on my feature and project in an organized manner with **kanban boards**
5. Helped other people with their bugs, features, and issues

## Links
**old feature blog:** https://nulxn.github.io/nolan_2025/posts/project

**astronet self-grade issue:** https://github.com/DNHS-Neptune/neptune_frontend/issues/26

**neptune user story issue & burndown list:** https://github.com/DNHS-Neptune/neptune_frontend/issues/7

**about page issue & steps:** https://github.com/DNHS-Neptune/neptune_frontend/issues/12

### Recent (good stuff)
**kanban board:** https://github.com/users/nulxn/projects/2
- [astronet image burndown](https://github.com/users/nulxn/projects/2/views/1?pane=issue&itemId=90060347&issue=DNHS-Neptune%7Cneptune_frontend%7C18)
- [flashcards (new feature) burndown](https://github.com/users/nulxn/projects/2/views/1?pane=issue&itemId=100053735&issue=nulxn%7Cathletic-bot%7C4)

## CPT & Project

Thanks for sharing your code! Now, I'll go through the AP Computer Science Principles Create Task requirements and cite the relevant parts of your code, explaining how they fulfill each requirement.

---

### Program Purpose and Function
- **Input:**  
  - The user provides input through the text fields:
    ```js
    <input type="text" id="front" placeholder="Front" />
    <input type="text" id="back" placeholder="Back" />
    ```
  - The input is processed when the user clicks the "Create" button:
    ```js
    <button onclick="createNolan(front.value, back.value)">Create</button>
    ```
  
- **Program Functionality:**  
  - The program allows users to create, update, delete, and flip flashcards.
  - Cards are created dynamically and stored in a backend database.

- **Output:**  
  - The flashcards are displayed dynamically inside the `.cards` container:
    ```js
    function addCard(nolan) {
      const cards = document.querySelector(".cards");
      const card = document.createElement("div");
      card.classList.add("card");
      card.innerHTML = `<h3>${nolan.front}</h3>`;
    }
    ```

### Data Abstraction
- **List (or Collection Type) Usage:**
  - The program fetches an array (list) of flashcards from the backend:
    ```js
    fetch(`${pythonURI}/api/flashcards`, fetchOptions)
      .then((res) => res.json())
      .then(async (nolans) => {
        nolans.forEach(addCard);
      });
    ```
  - Here, `nolans` is an array containing multiple flashcards.

- **Storing Data in the List:**
  - When a new flashcard is created, it is added to the backend:
    ```js
    function createNolan(front, back) {
      fetch(`${pythonURI}/api/flashcards`, {
        ...fetchOptions,
        method: "POST",
        body: JSON.stringify({ front, back }),
      })
        .then((res) => res.json())
        .then(addCard);
    }
    ```

- **Using the List to Fulfill the Program's Purpose:**
  - The stored flashcards are displayed dynamically:
    ```js
    nolans.forEach(addCard);
    ```
  - Each card is processed and displayed from the list.

### Managing Complexity
- **How the List Manages Complexity:**
  - Without the list, each flashcard would have to be manually created and managed.
  - The list allows for:
    - Easy retrieval and display of multiple flashcards.
    - A more scalable approach where adding more flashcards does not require additional code.
    - Simple iteration through the flashcards with `.forEach(addCard);`.

### Procedural Abstraction
- **Student-Developed Procedure with a Parameter:**
  - The `addCard(nolan)` function:
    ```js
    function addCard(nolan) {
      const card = document.createElement("div");
      card.classList.add("card");
      card.innerHTML = `<h3>${nolan.front}</h3>`;
    }
    ```
  - **Parameter:** `nolan` (an object containing the front and back of a flashcard).
  - **Effect of Parameter:** The function creates a flashcard dynamically based on the provided data.

- **Procedure Call:**
  - The function is called when flashcards are retrieved from the backend:
    ```js
    nolans.forEach(addCard);
    ```

### Algorithm Implementation
- **Algorithm with Sequencing, Selection, and Iteration:**
  - **Sequencing:** The process of fetching and displaying flashcards follows a clear sequence.
  - **Selection:** Cards have an interactive flip mechanism:
    ```js
    card.addEventListener("click", () => {
      if (isFlipped) {
        card.innerHTML = `<h3>${nolan.front}</h3>`;
      } else {
        card.innerHTML = `<h3>${nolan.back}</h3><p>${nolan.front}</p>`;
      }
      isFlipped = !isFlipped;
    });
    ```
  - **Iteration:** Iterating through the flashcards to display them:
    ```js
    nolans.forEach(addCard);
    ```
    
### Testing
- **Two Different Calls to the Procedure:**
  - `addCard({ front: "What is 2+2?", back: "4" })`
  - `addCard({ front: "What is the capital of France?", back: "Paris" })`
  - These calls provide different arguments and create different cards.

- **Conditions Tested:**
  - Different flashcards should be displayed correctly.
  - The card flip function should correctly show/hide content.

- **Results Identified:**
  - Clicking a card should correctly toggle between front and back content.
  - The expected output (flashcards appearing and flipping correctly) is achieved.

## Looking Forward
