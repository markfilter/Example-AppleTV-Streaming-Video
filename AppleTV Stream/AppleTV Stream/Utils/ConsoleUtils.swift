//
//  ConsoleUtils.swift
//  WeatherStation
//
//  Created by Mark Filter on 2/16/18.
//  Copyright © 2018 Mark Filter. All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge, publish, distribute,
//  sublicense, and/or sell coppies of the software and to permit persons to whome the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
//  NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

class Log {
    
    /**
     Displays informative output to the console.
     - Parameters:
     - TAG: The filter TAG to be used to isolate the textual information.
     - message: The message to be displayed in the console.
     - Author: Mark Filter
     */
    internal static func i(TAG: String, message: String) {
        print("i: ", TAG, ": ", message)
    }
    
    /**
     Displays debug output to the console.
     - Parameters:
     - TAG: The filter TAG to be used to isolate the textual information.
     - message: The message to be displayed in the console.
     - Author: Mark Filter
     */
    internal static func d(TAG: String, message: String) {
        print("d: ", TAG, ": ", message)
    }
    
}

