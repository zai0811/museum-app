import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="department-city-picker"
export default class extends Controller {
  // To let stimulus connect with the html elements, use " data: {(controller_name)_target: "citySelect" } "
  // then this.citySelectTarget will be available in stimulus
  static targets = [ "citySelect" ]
  change(event) {
    // Get the selected department id
    let departmentId = event.target.selectedOptions[0].value
    // Get the city selector id to use it on cities.turbo_stream.erb
    let target = this.citySelectTarget.id

    // call the MuseumRegistrationRequestsController.cities(target, department)
    get(`/museum_registration_requests/cities?target=${target}&department=${departmentId}`, { responseKind: "turbo-rails" })
  }
}
