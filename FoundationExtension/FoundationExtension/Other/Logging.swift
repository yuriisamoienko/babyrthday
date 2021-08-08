//
//  Logging.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation

// MARK: Public Functions

//usage: fatalMistake(_ message: String)
//usage: fatalMistake(_ message text: String, _ condition: Bool)
public func fatalMistake(_ message: String, condition: Bool = true, file: String = #file, line: UInt = #line, function: String = #function) {
    if condition == false {
        return
    }
    printFuncLog(message, isError: true, file: file, line: line, function: function)
    if enableFatalMistake == false {
        return
    }
    fatalErrorEx(message, file: file, line: line, function: function)
}

//usage: fatalErrorEx(_ message: String)
//it show more precise error on IDE when crash with fatalError
public func fatalErrorEx(_ message: String, file: String = #file, line: UInt = #line, function: String = #function) -> Never {
    let fullMessage = funcLog(error: nil, file: file, line: line, function: function) + message
    return fatalError(fullMessage, file: "", line: line)
}

//call it 'printFuncLog()' or 'printFuncLog("some_value")'
public func printFuncLog(_ withString: String = "", file: String = #file, line: UInt = #line, function: String = #function) {
    printFuncLog(withString, isError: false, file: file, line: line, function: function)
}

//call it 'funcLog()'; use directly in function, not in closure - otherwise you'll get the closure info; use with 'showProgrammErrorAlert'
public func funcLog(file: String = #file, line: UInt = #line, function: String = #function) -> String {
    let result = "\(file):\(line) : \(function) : "
    return result
}

//call it 'funcLog(error)'
public func funcLog(error: Error?, file: String = #file, line: UInt = #line, function: String = #function) -> String {
    var fileName = file
    if let value = file.split(separator: "/").last {
        fileName = String(value)
    }
    return "\(fileName):\(line) : \(function) : error: " + (error?.localizedDescription ?? "")
}

// MARK: Private Functions

fileprivate func printFuncLog(_ withString: String = "", isError: Bool, file: String = #file, line: UInt = #line, function: String = #function) {
    let value = funcLog(file: file, line: line, function: function)
    printIt(value + " " + withString, isError: isError)
}

fileprivate func printIt(_ value: String, isError: Bool) {
    var sendToServer = false
    #if !DEBUG
    if isDebuggerAttached() == false {
        sendToServer = true
    }
    #endif
    if isDevEnvironment() == true {
        print(value)
    }
}

fileprivate let enableFatalMistake: Bool = isDebuggerAttached()
