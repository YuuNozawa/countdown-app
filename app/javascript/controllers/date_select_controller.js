import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["year", "month", "day"];

    connect() {
        this.updateDays();
    }

    change() {
        this.updateDays();
    }

    updateDays() {
        const year = parseInt(this.yearTarget.value, 10);
        const month = parseInt(this.monthTarget.value, 10);

        if(!year || !month) {
            this.dayTarget.innerHTML = "<option value=''>Day</option>";
            return;
        }

        const daysInMonth = new Date(year, month, 0).getDate();
        let options = "<option value=''>Day</option>"
        for(let day = 1; day <= daysInMonth; day++) {
            const selected = (this.dayTarget.dataset.dateSelectSelected == day) ? "selected" : "";
            options += `<option value="${day}" ${selected}>${day}</option>`
        }

        this.dayTarget.innerHTML = options;
    }
}