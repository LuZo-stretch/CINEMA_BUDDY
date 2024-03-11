import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { userMatchId: Number };

  match() {
    const userMatchId = this.userMatchIdValue;
    console.log('User Match ID:', userMatchId);

    fetch(`/matches`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ user_match_id: userMatchId }),
    })

    .then(response => {
      if (response.ok) {
        alert("Like sent! You have a match when the other user likes you back");
    } else {
        alert("Error sending like");
     }
    })
    // .then(data => {
    //   console.log('Match response:', data);
    // })
    // .catch(error => {
    //   if (error.error) {
    //     console.error('Error details:', error.error);
    //   }
    //   console.error('Error occurred:', error);
    // });
  }
}

// class ResponseError extends Error {
//   constructor(message, { status, error } = {}) {
//     super(message);
//     this.name = 'ResponseError';
//     this.status = status;
//     this.error = error;
//   }
// }
