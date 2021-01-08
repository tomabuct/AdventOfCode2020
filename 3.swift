#!/usr/bin/swift

import Foundation

let s = try! String(contentsOfFile: "./3.input", encoding: .ascii)

var grid = s
    .split(separator: "\n")
    .map { Array($0) }


func trees(forSlope slope: (Int, Int)) -> Int {
  var y = 0, x = 0, trees = 0
  while (y < grid.count) {
    if (grid[y][x] == "#") {
      trees += 1
    }
    x = (x + slope.0) % grid[y].count
    y = y + slope.1
  }
  return trees
}

print(
  trees(forSlope: (1, 1)) *
  trees(forSlope: (3, 1)) *
  trees(forSlope: (5, 1)) *
  trees(forSlope: (7, 1)) *
  trees(forSlope: (1, 2))
)
