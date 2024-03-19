import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-movies"
export default class extends Controller {
  static values = { movieId: Number, liked: Boolean }
  initialize() {
    this.likedId = 0
  }
  connect() {
    this.updateIcon();
  }

  toggle(event) {
    event.preventDefault();
    if (this.likedValue) {
      this.unlike();
    } else {
      this.like();
    }
  }

  like() {
    fetch(`/movies/${this.movieIdValue}/liked_movies`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({ movie_id: this.movieIdValue })
    })
    .then(response => response.json())
    .then((data) => {
      this.likedId = data.liked_id
      this.likedValue = true;
      this.updateIcon();
    })
    // .then(response => {
    //   if(response.ok) {
    //     console.log(response)
    //     this.likedValue = true;
    //     this.updateIcon();
    //   }
    // });
  }

  unlike() {
    fetch(`/movies/${this.movieIdValue}/liked_movies/${this.likedId}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        "Content-Type": "application/json"
      }
    }).then(response => {
      if(response.ok) {
        this.likedValue = false;
        this.updateIcon();
      }
    });
  }

  updateIcon() {
    const icon = this.element.querySelector('.fa-heart');
    if (icon) {
      if (this.likedValue) {
        icon.classList.remove('far');
        icon.classList.add('fas');
      } else {
        icon.classList.remove('fas');
        icon.classList.add('far');
      }
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element.getAttribute("content");
  }
}
