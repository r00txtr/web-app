document.addEventListener("DOMContentLoaded", function() {
    // DOM is fully loaded
    console.log("DOM is ready!");

    // Example interactivity
    var heading = document.querySelector("h1");
    heading.addEventListener("click", function() {
        alert("You clicked the heading!");
    });
});

