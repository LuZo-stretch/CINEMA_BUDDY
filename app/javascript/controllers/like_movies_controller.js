import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like-movies"
export default class extends Controller {
  static values = { movieId: Number, liked: Boolean }
  connect() {
    console.log('Hello')
  }
}
