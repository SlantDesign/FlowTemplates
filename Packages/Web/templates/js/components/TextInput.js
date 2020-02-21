class TextInput extends ToggleButton {
  constructor(
    forwardTimeline,
    reverseTimeline,
    timer,
    loop,
    state,
    callback,
    textInputLabel
  ) {
    super(forwardTimeline, reverseTimeline, timer, loop, state, callback);
    this.rootElement = this.forwardTimeline.rootElement;
    this.textInputLabel = textInputLabel;
    this.addEventListener();
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
    let input = this.rootElement.getElementById("Hoshi-inputID-input");
    if (input.value.length == 0) {
      this.toggle(true);
    } else {
      this.state = true;
    }
  }

  set textInputLabel(text) {
    this.rootElement.querySelector("#Hoshi .labeloff").innerHTML = text;
    this.rootElement.querySelector("#Hoshi .labelon").innerHTML = text;
  }

  get textInputLabel() {
    return this.rootElement.querySelector("#Hoshi .labelon").innerHTML
  }
}

function createTextInput(
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
    forwardTimeline,
    reverseTimeline,
    timer,
    false,
    false,
    callback,
    textInputLabel
  );
}
