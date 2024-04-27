import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["cityDropdown"];

    connect() {
        this.loadCities();
    }

    loadCities() {
        const departmentId = this.departmentId();
        if (!departmentId) {
            return;
        }
        fetch(`/departments/${departmentId}/cities`)
            .then(response => response.json())
            .then(data => this.renderCities(data));
    }

    renderCities(cities) {
        const cityDropdown = this.cityDropdownTarget;
        cityDropdown.innerHTML = ""; // Clear existing options
        cities.forEach(city => {
            const option = document.createElement("option");
            option.value = city.id;
            option.text = city.name;
            cityDropdown.appendChild(option);
        });
    }

    departmentId() {
        return this.data.get("departmentId");
    }
}
