import Foundation
import QuartzCore

final class Stopwatch {
    static func measure<T>(_ action: (() -> (T))) -> (T, Double) {
        let a = CACurrentMediaTime()
        
        let r = action()
        
        let time = CACurrentMediaTime() - a
        
        return (r, time * 1_000_000)
    }
}
