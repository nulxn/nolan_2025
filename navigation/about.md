---
layout: page
title: About
permalink: /about/
---

**Nolan (kinda) knows how to code.**
I am a student at Del Norte High School enrolled in AP CSE. I hope to advance my knowledge of coding and work enviornments.

<script>
    var person = {
        name: "Nolan Hightower",
        age: 14,
        classes: [
            "Integrated Math 3a",
            "Spanish 4",
            "Digital Photography 2",
            "AP World",
            "AP CSP"
        ],
        interests: [
            "Coding",
            "Running"
        ],
        pets: {
            type: "dog",
            name: "Stanley",
            years: "0.44"
        }
    };

    console.log(person);
    person.interests.push("Sleepings");
    console.log("Changed object: " + person);
    console.log("Changed key" + person.interests);
    console.log(person.years / 7);
    console.log(typeof person.name);
    console.log(typeof person.age);
    console.log(typeof person.pets);
</script>
