import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="department-city-picker"
export default class extends Controller {
  change(event) {
    console.log("Hello world.")
  }
}
