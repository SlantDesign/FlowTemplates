/**
 * A hover element that can be toggled on and off with
 * forward and reverse animations. The forward and reverse animations are triggered when
 * transitioning from the off -> on and on -> off states respectively.
 */
class HoverElement {
    /**
     * @constructor
     *
     * @param {Timeline} forwardTimeline
     *  Animation played when hover element transitions from off to on.
     *
     * @param {Timeline} reverseTimeline
     *  Animation played when hover element transitions from on to off.
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
    constructor(forwardTimeline, reverseTimeline, timer, loop, state, callback) {
      this.callback = callback;
      this.state = state;
      this.timer = timer;
      this.forwardTimeline = forwardTimeline;
      this.reverseTimeline = reverseTimeline;
      this.player = new Player(forwardTimeline, timer, loop, 0, callback);
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
      this.setTimeline(this.forwardTimeline);
    }
  
    /**
     * Plays the reverse timeline associated with the hover element.
     * This method should be invoked when the mouse leaves the bounds of the hover element.
     */
    exit() {
      this.setTimeline(this.reverseTimeline);
    }
  
    /**
     * Plays the given `timeline` from the point in the time the previous timeline was stopped. 
     * 
     * @param {timeline} timeline 
     * The next timeline to play.
     */
    setTimeline(timeline) {
      let nextTime = this.player.duration - this.player.currentTime;
      this.player.timeline = timeline;
      this.player.currentTime = nextTime;
      this.player.play();
    }
  }

  function createHoverElement(rootID, callback, resourcesPath, ForwardTimeline, ReverseTimeline) {
    let shadowDomContainer = document.getElementById(rootID);
    let shadowRoot = shadowDomContainer.shadowRoot;
    let timer = shadowRoot.getElementById("timerID");
    let forwardTimeline = new ForwardTimeline(shadowRoot, resourcesPath);
    let reverseTimeline = new ReverseTimeline(shadowRoot, resourcesPath);
    return new HoverElement(
      forwardTimeline,
      reverseTimeline,
      timer,
      false,
      false,
      callback
    );
  }