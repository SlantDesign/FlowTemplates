class TextInput extends ToggleButton {
  constructor(
    timelineName,
    forwardTimeline,
    reverseTimeline,
    timer,
    loop,
    state,
    callback,
    textInputLabel
  ) {
    super(forwardTimeline, reverseTimeline, timer, loop, state, callback);
    this.timelineName = timelineName
    this.rootElement = this.forwardTimeline.rootElement;
    this.textInputLabel = textInputLabel;
    this.addEventListener();
    this.labelClass = ".label"
  }
  addEventListener() {
    const eventIds = ["focus", "blur"];
    eventIds.forEach(eventId => {
      this.rootElement.addEventListener(
        eventId,
        () => this.toggleTextInput(this.rootElement),
        true
      );
    });
  }

  toggleTextInput() {
    let input = this.rootElement.getElementById(`${this.timelineName}-inputID-input`);
    if (input.value.length == 0) {
      this.toggle(true);
    } else {
      this.state = true;
    }
  }

  set textInputLabel(text) {
    let label = this.rootElement.querySelector(`#${this.timelineName} .label`);
    if (label !== null) {
        label.innerHTML = text;
      return;
    }

    let off = this.rootElement.querySelector(`#${this.timelineName} .labeloff`)
    if (off !== null) {
      off.innerHTML = text;
    }

    let on = this.rootElement.querySelector(`#${this.timelineName} .labelon`)
    if (on !== null) {
      on.innerHTML = text;
    }
  }

  get textInputLabel() {
    let label = this.rootElement.querySelector(`#${this.timelineName} .label`);
    if (label !== null) {
      return label.innerHTML;
    }

    return this.rootElement.querySelector(`#${this.timelineName} .labelon`).innerHTML
  }
}

function createTextInput(
  timelineName,
  rootID,
  callback,
  resourcesPath,
  ForwardTimeline,
  ReverseTimeline,
  textInputLabel
) {
  let shadowDomContainer = document.getElementById(rootID);
  let shadowRoot = shadowDomContainer.shadowRoot;
  let timer = shadowRoot.getElementById("timerID");
  let forwardTimeline = new ForwardTimeline(shadowRoot, resourcesPath);
  let reverseTimeline = new ReverseTimeline(shadowRoot, resourcesPath);
  return new TextInput(
    timelineName,
    forwardTimeline,
    reverseTimeline,
    timer,
    false,
    false,
    callback,
    textInputLabel
  );
}
