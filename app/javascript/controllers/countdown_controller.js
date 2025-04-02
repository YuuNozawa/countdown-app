import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ターゲットとしてiconButtonを定義
  static targets = ["iconButton"]
  
  save(event) {
    alert("保存しました");
  }

  selectIcon(e) {
    this.iconButtonTargets.forEach((btn) => {
      btn.setAttribute('aria-pressed', 'false');
    });

    e.currentTarget.setAttribute('aria-pressed', 'true');
  }
}
