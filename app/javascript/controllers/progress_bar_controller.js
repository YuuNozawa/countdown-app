import { Controller } from "@hotwired/stimulus";

const MS_PER_DAY = 1000 * 60 * 60 * 24;
const BLUE  = "#60A5FA"; // Tailwind の blue-400
const RED   = "#EF4444"; // Tailwind の red-500

export default class extends Controller {
  static targets = ["bar"];
  static values  = {
    eventDay: String,    
    createdAt: String,   
    duration: Number     
  };

  connect() {
    
    const dur = this.durationValue || 2000;

    
    const eventDate   = new Date(this.eventDayValue);
    const createdDate = new Date(this.createdAtValue);
    const today       = new Date();

    
    const totalDays     = Math.max(0, Math.round((eventDate - createdDate) / MS_PER_DAY));
    const remainingDays = Math.max(0, Math.round((eventDate - today) / MS_PER_DAY));

    const percent = totalDays > 0
      ? Math.min(100, Math.round((remainingDays / totalDays) * 100))
      : 0;

    
    this.barTarget.style.width = "100%";
    
    this.barTarget.style.transition = `width ${dur}ms ease-out, background-color ${dur}ms ease-out`;

    
    setTimeout(() => {
      this.barTarget.style.width = `${percent}%`;
      if (percent < 20) {
        this.barTarget.style.backgroundColor = RED;
      }
    }, 50);
  }
}
