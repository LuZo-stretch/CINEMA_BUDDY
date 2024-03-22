import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Show the modal when the controller connects
    var myModal = new bootstrap.Modal(this.element);
    myModal.show();
  }
}
