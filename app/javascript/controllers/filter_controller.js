// app/javascript/controllers/filter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field" ]

  filter() {
    // You can add debounce logic here if needed.
    this.element.requestSubmit()
  }
}
