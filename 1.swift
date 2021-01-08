#!/usr/bin/swift

import Foundation 

let s = try! String(contentsOfFile: "./1.input", encoding: .ascii)
let ns = s.split(separator: "\n").map { Int($0)! }
for n in ns {
    for m in ns {
      for o in ns {
        if n + m + o == 2020 { print(n * m * o) }
      }
    }
}
