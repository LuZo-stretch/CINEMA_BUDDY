import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heartIcon"];
  static values = { userId: Number };

  like() {
    const userId = this.userIdValue;
    console.log('User ID:', userId);
    this.heartIconTarget.classList.toggle(this.clickedClass);
    // Make an AJAX request to create a match
    fetch("/matches", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ user_match_id: this.userIdValue }),
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then(data => {
      console.log('data: ', data)
      if (data.matched) {
      alert("It's a match!");
      // window.location.href = `/matches/${data.match_id}`;
      } else {
        window.location.reload();
      }
    });
  }
}
