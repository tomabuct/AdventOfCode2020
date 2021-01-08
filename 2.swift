#!/usr/bin/swift

import Foundation

func isValid1(password: String, perPattern pattern: String) -> Bool {
    let patternSplit = pattern.split(separator: " ")
    let limits = patternSplit[0].split(separator: "-").map { Int($0)! }
    let min = limits[0]
    let max = limits[1]
    let character = patternSplit[1]
    let count = password.filter { String($0) == character }.count
    return count >= min && count <= max
}

func isValid2(password: String, perPattern pattern: String) -> Bool {
    let patternSplit = pattern.split(separator: " ")
    let limits = patternSplit[0].split(separator: "-").map { Int($0)! }
    let i = limits[0]
    let j = limits[1]
    let character = patternSplit[1]
    let passwordArray = Array(password)
    let f = String(passwordArray[i]) == character
    let s = String(passwordArray[j]) == character
    return f != s
}

let s = try! String(contentsOfFile: "./2.input", encoding: .ascii)

var r1 = s
    .split(separator: "\n")
    .map { $0.split(separator: ":") }
    .map { isValid1(password: String($0[1]), perPattern: String($0[0])) }
    .reduce(0) { $0 + ($1 ? 1 : 0) }

var r2 = s
    .split(separator: "\n")
    .map { $0.split(separator: ":") }
    .map { isValid2(password: String($0[1]), perPattern: String($0[0])) }
    .reduce(0) { $0 + ($1 ? 1 : 0) }


print(r1)
print(r2)
