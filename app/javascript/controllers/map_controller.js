import {Controller} from "@hotwired/stimulus"
import L from "leaflet"

// Connects to data-controller="map"
export default class extends Controller {
    static targets = ["container"]

    connect() {
        this.createMap();
        this.map.setView([-25.263741, -57.575928], 12);
    }

    createMap() {
        // init empty map inside container target
        this.map = L.map(this.containerTarget);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(this.map);
        console.log("on createMap")
    }

    disconnect() {
        this.map.remove();
    }
}
