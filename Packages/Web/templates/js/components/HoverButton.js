/**
 * A hover element that can be toggled on and off with
 * forward and reverse animations. The forward and reverse animations are triggered when
 * transitioning from the off -> on and on -> off states respectively.
 */
class HoverButton {
  /**
   * @constructor
   *
   * @param {Timeline} hoverTimeline
   *  Animation played when hover element transitions from off to on.
   *
   * @param {Timeline} hoverReverseTimeline
   *  The animation played when the cursor exits the element when it is 
   *  in the hovered state.
   * 
   * @param {Timeline} clickTimeline
   *  Animation played when the element is clicked in the hovered state.
   * 
   * @param {Timeline} clickReverseTimeline
   *  The animation played when the element is clicked in the clicked state.
   * 
   * @param {Timeline} resetTimeline
   *  The animation played when the cursor exits the bounds of the element 
   *  when it is in the clicked state.
   *
   * @param {String} timer
   *  The HTML Element for the Timer.
   *
   * @param {Boolean} loop
   *  True if the animation should restart upon completion false otherwise.
   *
   * @param {Boolean} state
   *  The initial state of the button.
   *
   * @param {function: () -> Void} callback
   * A callback function passed to the player that runs upon animation completion.
   * This callback does not take in any parameters.
   */
  constructor(hoverTimeline, hoverReverseTimeline, clickTimeline, clickReverseTimeline, resetTimeline, timer, elementID, state, callback) {
    this.callback = callback;
    this.state = state;
    this.lastState = state;
    this.timer = timer;
    this.hoverTimeline = hoverTimeline;
    this.hoverReverseTimeline = hoverReverseTimeline;
    this.clickTimeline = clickTimeline;
    this.clickReverseTimeline = clickReverseTimeline;
    this.resetTimeline = resetTimeline;
    this.player = new Player(hoverTimeline, timer, false, 0, callback);
    this.elementID = elementID
    /**
     * The states of the element.
     */
    this.states = {
      /**
       * The state the element is in when the cursor is not 
       * hovering over the element.
       */
      Start: 'start',
      /**
       * The state of the element is in when the cursor is 
       * hovering over the element.
       */
      Hovered: 'hovered',
      /**
       * The state the element is in after the 
       * element is clicked but before the cursor has exited 
       * the elements bounds.
       */
      Clicked: 'clicked',
    } 
  }

  /**
   * @return
   * Returns true if the `self` is currently being animated, otherwise returns false.
   */
  isAnimating() {
    return this.player.isPlaying();
  }

  /**
   * Plays the forward timeline associated with the hover element.
   * This method should be invoked when the mouse enters the bounds of the hover element.
   */
  enter() {
    if(this.lastState == this.states.Clicked) {
      this.completeCurrentAnimation()
    }
    this.setTimeline(this.hoverTimeline);
    this.lastState = this.state
    this.state = this.states.Hovered
    this.player.play()
  }

  /**
   * Plays the reverse timeline associated with the hover element.
   * This method should be invoked when the mouse leaves the bounds of the hover element.
   */
  exit() {
    switch (this.state) {
      case this.states.Hovered:
        if (this.lastState == this.states.Clicked) {
          this.completeCurrentAnimation()
        }
        this.setReverseTimeline(this.hoverReverseTimeline)
        break;
      case this.states.Clicked:
        this.completeCurrentAnimation()
        this.setReverseTimeline(this.resetTimeline)
        break;
    }

    this.lastState = this.state
    this.state = this.states.Start
    this.player.play()
  }

  /**
   * Plays the forward and reverse animations associated with the click event.
   */
  click() {
    switch (this.state) {
      case this.states.Hovered:
        if (this.lastState == this.states.Start) {
          this.completeCurrentAnimation()
          this.setTimeline(this.clickTimeline)
        } else {
          this.setReverseTimeline(this.clickTimeline)
        }
        break;
      case this.states.Clicked:
        this.setReverseTimeline(this.clickReverseTimeline)
        break;
    }

    this.lastState = this.state
    switch (this.state) {
      case this.states.Hovered:
        this.state = this.states.Clicked
        break;
      case this.states.Clicked:
        this.state = this.states.Hovered
        break;
    }
    this.player.play();
  }

  /**
   * Plays the given `timeline` from the point in the time the previous timeline was stopped. 
   * 
   * @param {timeline} timeline 
   * The next timeline to play.
   */
  setTimeline(timeline, time=0) {
    if (this.player.timeline !== timeline) {
      this.player.timeline = timeline;
      this.player.currentTime = time;
    }
  } 

  setReverseTimeline(timeline) {
    let nextTime = this.player.duration - this.player.currentTime;
    this.setTimeline(timeline, nextTime)
  }

  /**
   * Jumps to the end of the current animation to create smooth
   * transitions between states.
   */
  completeCurrentAnimation() {
    this.player.currentTime = (this.player.duration-0.001);
  }
}

/**
 * Used when button is a component
 */
function createHoverButton(rootID, callback, resourcesPath, ForwardTimeline, ReverseTimeline, ClickForwardTimeline, ClickReverseTimeline, ResetTimeline) {
  let shadowDomContainer = document.getElementById(rootID);
  let shadowRoot = shadowDomContainer.shadowRoot;
  let timer = shadowRoot.getElementById("timerID");

  //ID of the shadow dom container, do not change.
  let container = shadowRoot.getElementById("flowComponentContainerID");

  container.setAttribute("onmouseenter", `${rootID}.enter()`)
  container.setAttribute("onmouseleave", `${rootID}.exit()`)
  container.setAttribute("onclick", `${rootID}.click()`)
  let forwardTimeline = new ForwardTimeline(shadowRoot, resourcesPath);
  let reverseTimeline = new ReverseTimeline(shadowRoot, resourcesPath);
  let clickForwardTimeline = new ClickForwardTimeline(shadowRoot, resourcesPath);
  let clickReverseTimeline = new ClickReverseTimeline(shadowRoot, resourcesPath);
  let resetTimeline = new ResetTimeline(shadowRoot, resourcesPath);
  return new HoverButton(
    forwardTimeline,
    reverseTimeline,
    clickForwardTimeline,
    clickReverseTimeline,
    resetTimeline,
    timer,
    false,
    false,
    callback
  );
}