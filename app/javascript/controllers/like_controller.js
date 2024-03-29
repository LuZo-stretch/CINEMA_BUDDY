import { Controller } from "@hotwired/stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["heartIcon"];
  static values = {matchId: Number, userId: Number, match: Boolean};

  toggle(event) {
  event.preventDefault();
  console.log("liked Value:", this.matchValue)
    if (this.matchValue) {
      this.unlike();
    } else {
      this.like();
    }
  }

  like() {
    const matchId = this.matchIdValue;
    console.log('Match ID like:', matchId);
   // Make an AJAX request to create a match
    fetch("/matches", {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ match: this.userIdValue }),
    })

    .then( response => response.json())
    .then((data) => {
      this.matchValue = true;
      this.updateIcon(data);

      console.log('data: ', data)
      if (data.matched) {
        // alert("It's a match!");
        Swal.fire({
          title: "<strong>You Matched!</strong>",
          html: `
            Start <b>chatting</b>?
          `,
          showCloseButton: true,
          showCancelButton: true,
          focusConfirm: false,
          confirmButtonText: `
            <i class="fa fa-thumbs-up"></i> Chat now!
          `,
          confirmButtonAriaLabel: "Thumbs up, yes!",
          cancelButtonText: `
            <i class="fa fa-thumbs-down"></i> Later
          `,
          cancelButtonAriaLabel: "Thumbs down, later"
        })
        .then((result) => {
          console.log('data2: ', data)
          if (result.isConfirmed) {
          // Redirecting to chat page
            window.location.href = `/chats/${data.chat.id}`;
          }
        })
      }
    });
  }

  unlike() {
    console.log('Match ID unlike:', this.matchIdValue);
    fetch(`/matches`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ match: this.userIdValue }),
    })
    .then(response => {
      if(response.ok) {
        this.matchValue = false;
        return response.json()
      }
    })
    .then((data) => {
      this.updateIcon(data);
    })

  }

  updateIcon(data) {
    const heartIcon = document.getElementById(`heart-${this.userIdValue}`)
    if (heartIcon) {
      heartIcon.innerHTML = data.icon
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
