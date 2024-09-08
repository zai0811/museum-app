import {Controller} from "@hotwired/stimulus"

const APPROVED = 1
const REJECTED = 2
const ARCHIVED = 3

// Connects to data-controller="registration-request-modal"
export default class extends Controller {
    static targets = ["statusCheckbox", "approvalConfirmation", "rejectionConfirmation", "archivalConfirmation", "feedbackBox"]

    connect() {
        const modal = document.getElementById("confirmModal")
        if (modal) {
            modal.addEventListener("show.bs.modal", event => {
                const triggerBtn = event.relatedTarget
                const action = triggerBtn.getAttribute("data-bs-result")

                const title = modal.querySelector(".modal-title")
                const confirmBtn = modal.querySelector("#confirmBtn")

                title.textContent = `${action} solicitud`
                confirmBtn.setAttribute("value", action)
            })

            modal.addEventListener("hidden.bs.modal", event => {
                this.hideFields()
            })
        }
    }

    setApproved() {
        this.statusCheckboxTarget.setAttribute("value", APPROVED)
        this.approvalConfirmationTarget.removeAttribute("hidden")
    }

    setRejected() {
        this.statusCheckboxTarget.setAttribute("value", REJECTED)
        this.rejectionConfirmationTarget.removeAttribute("hidden")
        this.feedbackBoxTarget.removeAttribute("hidden")
    }

    setArchived() {
        this.statusCheckboxTarget.setAttribute("value", ARCHIVED)
        this.archivalConfirmationTarget.removeAttribute("hidden")
    }

    hideFields() {
        this.approvalConfirmationTarget.setAttribute("hidden", "hidden")
        this.rejectionConfirmationTarget.setAttribute("hidden", "hidden")
        this.archivalConfirmationTarget.setAttribute("hidden", "hidden")
        this.feedbackBoxTarget.setAttribute("hidden", "hidden")
    }
}
