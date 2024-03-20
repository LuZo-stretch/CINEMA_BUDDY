import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"];

  hideContent() {
    this.contentTarget.classList.toggle("d-none")
  }
}
