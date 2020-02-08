class Track {
  constructor(property, values, timingFunctions, times, element) {
    this.property = property;
    this.values = values;
    this.timingFunctions = timingFunctions;
    this.times = times;
    this.element = element;
    this.animations = this.createAllAnimations();
  }

  createAllAnimations() {
    let animations = [];
    for (const [index, timingFunction] of this.timingFunctions.entries()) {
        let from = this.values[index];
        let to = this.values[index + 1];
        let startTime = this.times[index];
        let endTime = this.times[index + 1];
        let id = `${this.element}${this.property}${index}`
      animations.push(
        new Animation(this.element, this.property, from, to, id, startTime, endTime, timingFunction)
      );
    }
    return animations;
  }
}
