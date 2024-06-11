import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-actions"
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}
