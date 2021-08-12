//
//  Funcs.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation

public func debounce(queue: DispatchQueue = .main, delay: Double, closure: @escaping() -> Void) {
    queue.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

public func debounceTask(queue: DispatchQueue = .main, delay: Double, closure: @escaping() -> Void) -> DispatchWorkItem {
    let work = DispatchWorkItem(block: { [closure] in
       closure()
    })
    queue.asyncAfter(deadline: .now() + delay, execute: work)
    return work
}

public func isDebuggerAttached() -> Bool {
    if debuggerAttached == false {
        var info = kinfo_proc()
        var mib : [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout<kinfo_proc>.stride
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        debuggerAttached = (info.kp_proc.p_flag & P_TRACED) != 0
    }
    return debuggerAttached
}

public func isDevEnvironment() -> Bool {
    var result = true
    #if !DEBUG
    if isDebuggerAttached() == false {
        result = false
    }
    #endif
    return result
}

fileprivate var debuggerAttached = false
