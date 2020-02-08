class Animation {
  constructor(
    element,
    property,
    from,
    to,
    id,
    startTime,
    endTime,
    timingFunction
  ) {
    this.element = element;
    this.property = property;
    this.from = from;
    this.to = to;
    this.id = id;
    this.startTime = startTime;
    this.endTime = endTime;
    this.timingFunction = timingFunction;
    this.webAnimation = this.createWebAnimation();
  }

  createWebAnimation() {
    let keyframe = {
      [this.property]: [`${this.from}`, `${this.to}`]
    };
    let options = {
      id: this.id,
      delay: this.startTime,
      duration: this.duration(),
      easing: this.timingFunction,
      composite: "add",
      fill: "forwards"
    };
    return this.element.animate(keyframe, options);
  }

  duration() {
      return this.endTime - this.startTime;
  }

  play() {
    let shouldPlay = this.currentTime < this.endTime
    if (shouldPlay) {
        this.webAnimation.play()
    }
  }

  pause() {
      this.webAnimation.pause()
  }

  get playState() {
      return this.webAnimation.playState
  }

  set currentTime(time) {
      this.webAnimation.currentTime = time
  }

  get currentTime() {
    return this.webAnimation.currentTime
  }
}
