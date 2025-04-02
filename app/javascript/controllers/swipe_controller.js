import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.startX = 0;
    this.currentX = 0;
    this.baseOffset = 0;     // タッチ開始時のtranslateX値
    this.threshold = 30;     // スナップ判定の閾値
    this.dragging = false;
  }

  touchStart(event) {
    this.startX = event.touches[0].clientX;
    this.dragging = true;

    // 現在のtranslateX値を取得
    const transform = this.itemTarget.style.transform;
    this.baseOffset = 0;
    if (transform && transform.includes("translateX(")) {
      const match = transform.match(/translateX\((-?\d+)px\)/);
      if (match) {
        this.baseOffset = parseInt(match[1], 10);
      }
    }

    // 背景のedit, deleteボタンの合計幅を取得
    const editButton = this.element.querySelector('[data-role="editButton"]');
    const deleteButton = this.element.querySelector('[data-role="deleteButton"]');
    this.totalButtonWidth = (editButton ? editButton.offsetWidth : 0) + (deleteButton ? deleteButton.offsetWidth : 0);
  }

  touchMove(event) {
    if (!this.dragging) return;
    this.currentX = event.touches[0].clientX;
    const deltaX = this.currentX - this.startX;
    let newOffset = this.baseOffset + deltaX;

    // newOffsetを -totalButtonWidth から 0 の間にクランプ
    if (newOffset > 0) {
      newOffset = 0;
    } else if (newOffset < -this.totalButtonWidth) {
      newOffset = -this.totalButtonWidth;
    }
    this.itemTarget.style.transform = `translateX(${newOffset}px)`;
  }

  touchEnd() {
    this.dragging = false;
    // touchMove時の最終位置を取得
    const transform = this.itemTarget.style.transform;
    let finalOffset = 0;
    if (transform && transform.includes("translateX(")) {
      const match = transform.match(/translateX\((-?\d+)px\)/);
      if (match) {
        finalOffset = parseInt(match[1], 10);
      }
    }

    // 絶対値が閾値を超えていれば「開いた」状態に、そうでなければ閉じた状態にスナップ
    if (Math.abs(finalOffset) > this.threshold) {
      this.itemTarget.style.transform = `translateX(-${this.totalButtonWidth}px)`;
    } else {
      this.itemTarget.style.transform = "translateX(0)";
    }
  }
}
