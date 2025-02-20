import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    // Toggle hidden class on the dropdown menu
    this.menuTarget.classList.toggle("hidden")
  }
}
