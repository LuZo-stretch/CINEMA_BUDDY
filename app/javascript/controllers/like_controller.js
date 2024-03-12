import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heartIcon"];
  static values = { userId: Number };

  like() {
    const userId = this.userIdValue;
    console.log('User ID:', userId);
    // Make an AJAX request to create a match
    fetch("/matches", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ user_match_id: this.userIdValue }),
    })
    .then(response => (response.json()))
    .then(data => {
      if (data.matched) {
          // Display a match message
      alert("It's a match!");
      window.location.href = `/matches/${data.match_id}`;
      } else {
      // Continue on the profiles page
        window.location.reload(); // Reload the page or handle navigation as needed
      }
    })
  }
}

// export default class extends Controller {
//   static values = { userMatchId: Number };

//   match() {
//     const userMatchId = this.userMatchIdValue;
//     console.log('User Match ID:', userMatchId);

//     fetch(`/matches`, {
//       method: 'POST',
//       headers: {
//         'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
//         'Accept': 'application/json',
//         'Content-Type': 'application/json'
//       },
//       body: JSON.stringify({ user_match_id: userMatchId }),
//     })

//     .then(response => {
//       console.log(response)
//       if (response.ok) {
//         // alert("Like sent! You have a match when the other user likes you back");
//         return response.json();
//       } else {
//         // alert("Error sending like");
//         throw new Error("Error sending like");
//      }
//     })
//     .then(data => {
//       if (data.match_created) {
//         alert("Like sent! You have a match when the other user likes you back");
//       } else {
//         alert("Like sent! Waiting for the other user to like back.");
//       }
//     })
//     // .then(data => {
//     //   console.log('Match response:', data);
//     // })
//     // .catch(error => {
//     //   if (error.error) {
//     //     console.error('Error details:', error.error);
//     //   }
//     //   console.error('Error occurred:', error);
//     // });
//   }
// }

// class ResponseError extends Error {
//   constructor(message, { status, error } = {}) {
//     super(message);
//     this.name = 'ResponseError';
//     this.status = status;
//     this.error = error;
//   }
// }
