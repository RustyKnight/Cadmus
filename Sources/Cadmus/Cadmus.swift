//
//  LogWrapperService.swift
//  LogWrapperKit
//
//  Created by Shane Whitehead on 17/10/17.
//  Copyright © 2017 Shane Whitehead. All rights reserved.
//

import Foundation

public struct CadmusService {
	public static var shared: LogService = DefaultCadmusService()
}

/// Delegates the output to what ever underlying implementation is been used
public protocol CadmusDelegate {
	func log(verbose: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(verbose: CustomStringConvertible,
					 file: StaticString,
					 function: StaticString,
					 line: UInt, date: Date)
	
	func log(info: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(info: CustomStringConvertible,
					 file: StaticString,
					 function: StaticString,
					 line: UInt, date: Date)
	
	func log(warning: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(warning: Error, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(warning: CustomStringConvertible,
					 file: StaticString,
					 function: StaticString,
					 line: UInt, date: Date)
	
	func log(error: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(error: Error, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(error: CustomStringConvertible,
					 file: StaticString,
					 function: StaticString,
					 line: UInt, date: Date)
	
	func log(debug: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(debug: CustomStringConvertible,
					 file: StaticString,
					 function: StaticString,
					 line: UInt, date: Date)
}

public struct ConsoleDelegate: CadmusDelegate {
	
	public init() {}
	
	func log(prefix: String, message: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		let components = file.description.components(separatedBy: "/")
		guard let name = components.last else {
			print("[\(prefix) \(file):\(function)@\(line)]: \(message)")
			return
		}
		print("[\(prefix) \(name):\(function)@\(line)]: \(message)")
	}
	
	public func log(verbose: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(prefix: "📢", message: verbose, file: file, function: function, line: line, date: date)
	}
	
	public func log(verbose: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(verbose: verbose.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(info: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(prefix: "💡", message: info, file: file, function: function, line: line, date: date)
	}
	
	public func log(info: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(info: info.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(warning: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(prefix: "☢", message: warning, file: file, function: function, line: line, date: date)
	}
	
	public func log(warning: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(warning: warning.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(warning: Error, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(warning: "\(warning)", file: file, function: function, line: line, date: date)
	}
	
	public func log(error: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(prefix: "🔥", message: error, file: file, function: function, line: line, date: date)
	}
	
	public func log(error: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(error: error.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(error: Error, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(error: "\(error)", file: file, function: function, line: line, date: date)
	}
	
	public func log(debug: String, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(prefix: "🐞", message: debug, file: file, function: function, line: line, date: date)
	}
	
	public func log(debug: CustomStringConvertible, file: StaticString, function: StaticString, line: UInt, date: Date) {
		log(debug: debug.description, file: file, function: function, line: line, date: date)
	}
}

public protocol LogService {
	var delegate: CadmusDelegate { get set }
	
	func log(verbose: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(
		verbose: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt, date: Date)
	
	func log(info: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(
		info: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt, date: Date)
	
	func log(warning: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(warning: Error, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(
		warning: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt, date: Date)
	
	func log(error: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(error: Error, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(
		error: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt, date: Date)
	
	func log(debug: String, file: StaticString, function: StaticString, line: UInt, date: Date)
	func log(
		debug: CustomStringConvertible,
		file: StaticString ,
		function: StaticString ,
		line: UInt, date: Date)
}

class DefaultCadmusService: LogService {
	
	var delegate: CadmusDelegate = ConsoleDelegate()
	
	public func log(verbose: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(verbose: verbose, file: file, function: function, line: line, date: date)
	}
	
	public func log(
		verbose: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line, date: Date) {
		delegate.log(verbose: verbose.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(info: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(info: info, file: file, function: function, line: line, date: date)
	}
	
	public func log(
		info: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line, date: Date) {
		delegate.log(info: info.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(warning: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(warning: warning, file: file, function: function, line: line, date: date)
	}
	
	public func log(warning: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(warning: "\(warning)", file: file, function: function, line: line, date: date)
	}
	
	public func log(
		warning: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line, date: Date) {
		delegate.log(warning: warning.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(error: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(error: error, file: file, function: function, line: line, date: date)
	}
	
	public func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(error: "\(error)", file: file, function: function, line: line, date: date)
	}
	
	public func log(
		error: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line, date: Date) {
		delegate.log(error: error.description, file: file, function: function, line: line, date: date)
	}
	
	public func log(debug: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date) {
		delegate.log(debug: debug, file: file, function: function, line: line, date: date)
	}
	
	public func log(
		debug: CustomStringConvertible,
		file: StaticString = #file,
		function: StaticString = #function,
		line: UInt = #line, date: Date) {
		delegate.log(debug: debug.description, file: file, function: function, line: line, date: date)
	}
}

public func log(verbose: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(verbose: verbose, file: file, function: function, line: line, date: date)
}

public func log(
	verbose: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(verbose: verbose.description, file: file, function: function, line: line, date: date)
}

public func log(info: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(info: info, file: file, function: function, line: line, date: date)
}

public func log(
	info: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(info: info.description, file: file, function: function, line: line, date: date)
}

public func log(warning: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(warning: warning, file: file, function: function, line: line, date: date)
}

public func log(warning: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(warning: "\(warning)", file: file, function: function, line: line, date: date)
}

public func log(
	warning: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(warning: warning.description, file: file, function: function, line: line, date: date)
}

public func log(error: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(error: error, file: file, function: function, line: line, date: date)
}

public func log(error: Error, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(error: "\(error)", file: file, function: function, line: line, date: date)
}

public func log(
	error: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(error: error.description, file: file, function: function, line: line, date: date)
}

public func log(debug: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(debug: debug, file: file, function: function, line: line, date: date)
}

public func log(
	debug: CustomStringConvertible,
	file: StaticString = #file,
	function: StaticString = #function,
	line: UInt = #line, date: Date = Date()) {
	CadmusService.shared.log(debug: debug.description, file: file, function: function, line: line, date: date)
}
