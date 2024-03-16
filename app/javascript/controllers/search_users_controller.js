import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  update() {
    const url = `${this.element.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { "Accept": "application/json" } })
      .then(response => response.json())
  }
}
