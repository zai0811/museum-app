import {Controller} from "@hotwired/stimulus"
import L from "leaflet"

// Connects to data-controller="museum-map"
export default class extends Controller {
    static targets = ["container", "editBtn"]
    static values = {lat: Number, long: Number, id: Number}

    connect() {
        this.createMap();
    }

    createMap() {
        this.map = L.map(this.containerTarget);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(this.map);

        let latitude = this.latValue
        let longitude = this.longValue

        // New museums will not have any markers and will have a default view of Asuncion
        if (latitude === 0.0 && longitude === 0.0) {
            this.map.setView([-25.280124, -57.635032], 12);
        } else {
            this.map.setView([latitude, longitude], 12);
            this.marker = L.marker([latitude, longitude]).addTo(this.map);
        }
    }

    editCoordinates(event) {
        this.map.on('click', (event) => {
            if (this.marker !== undefined) {
                this.map.removeLayer(this.marker);
            }
            this.marker = L.marker(event.latlng).addTo(this.map);

            this.latValue = event.latlng.lat
            this.longValue = event.latlng.lng

            let lat = document.getElementById("museum_latitude")
            let long = document.getElementById("museum_longitude")

            lat.setAttribute("value", this.latValue)
            long.setAttribute("value", this.longValue)
        });

        this.editBtnTarget.setAttribute("hidden", "hidden");
        let formActions = document.getElementById("formActions")
        formActions.removeAttribute("hidden")
    }


    disconnect() {
        this.map.remove();
    }
}
