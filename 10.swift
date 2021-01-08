
import Foundation

let path = "10.input"
let input = try! String(contentsOfFile: path).trimmingCharacters(in: .newlines)
let adapters = input.components(separatedBy: .newlines).map { Int($0)! }.sorted()
let joltages = [0] + adapters + [ adapters.last! + 3]

let diffs = joltages
    .enumerated()
    .compactMap { $0.0 == 0 ? nil : $0.1 - joltages[$0.0 - 1] }
let diffCounts = Dictionary(grouping: diffs, by: { $0 }).mapValues { $0.count }
print(diffCounts.values.reduce(1) { $0 * $1 })

func pathsFor(joltages: [Int], cache: inout [[Int]: Int]) -> Int {
    if let r = cache[joltages] { return r }
    guard let first = joltages.first else { return 0 }
    guard joltages.count > 1 else { return 1 }
    
    let secondIndex = joltages.startIndex + 1
    let paths = (secondIndex...joltages.endIndex).reduce(0) {
        let subs = joltages[$1...]
        guard let next = subs.first else { return $0 }
        guard next - first <= 3 else { return $0 }
        return $0 + pathsFor(joltages: Array(subs), cache: &cache)
    }
    cache[joltages] = paths
    return paths
}

var cache = [[Int]: Int]()
print(pathsFor(joltages: joltages, cache: &cache))