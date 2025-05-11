
import Foundation

extension DispatchQueue {
    
    static func onMainIfRequired(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            let workItem = DispatchWorkItem(block: work)
            main.async(execute: workItem)
        }
    }
}
