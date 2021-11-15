// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import Foundation

class ProgressSimulator {
    struct Defaults {
        static let totalUnitCount: Int64 = 60
        static let timeInterval: TimeInterval = 1/60
        static let beginInterval: TimeInterval = 0.25
        static let resetInterval: TimeInterval = 1
    }

    let progress = Progress(totalUnitCount: Int64(ProgressSimulator.Defaults.totalUnitCount))

    private var timer: Timer?
    var continuous = true

    func simulateProgress() {
        let newTimer = Timer(timeInterval: ProgressSimulator.Defaults.timeInterval, target: self, selector: #selector(progressUnit), userInfo: nil, repeats: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + ProgressSimulator.Defaults.beginInterval) {
            RunLoop.main.add(newTimer, forMode: .default)
        }

        progress.completedUnitCount = 0

        timer = newTimer
    }

    func endProgress() {
        timer?.invalidate()
        if continuous {
            DispatchQueue.main.asyncAfter(deadline: .now() + ProgressSimulator.Defaults.resetInterval) {
                self.simulateProgress()
            }
        }
    }

    @objc
    func progressUnit() {
        progress.completedUnitCount += 1
        if progress.fractionCompleted > 1 {
            endProgress()
        }
    }
}
