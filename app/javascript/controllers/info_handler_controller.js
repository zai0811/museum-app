import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="info-handler"
export default class extends Controller {
  static targets = ["infoOverlay", "toggleLink"]
  toggleInfo(){
    if (this.infoOverlayTarget.classList.contains('expanded')) {
      this.infoOverlayTarget.classList.remove('expanded');
      this.infoOverlayTarget.classList.add('text-truncate');
      this.toggleLinkTarget.textContent = 'Ver más';
    } else {
      this.infoOverlayTarget.classList.add('expanded');
      this.infoOverlayTarget.classList.remove('text-truncate');
      this.toggleLinkTarget.textContent = 'Ver menos';
    }
  }
}
