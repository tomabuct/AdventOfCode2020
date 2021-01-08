import Foundation

let path = "./13.input"
let input = try! String(contentsOfFile: path)
    .trimmingCharacters(in: .newlines)
    .components(separatedBy: .newlines)

let arrival = Int(input[0])!
let buses = input[1]
    .components(separatedBy: .punctuationCharacters)
    .map { Int($0) }

let arrivesIns = buses
    .compactMap { $0 }
    .map { (busID: $0, arrivesIn: ((arrival / $0) * $0 + $0) - arrival) }
let earliest = arrivesIns.min { $0.arrivesIn < $1.arrivesIn }!
print(earliest.arrivesIn * earliest.busID)

let firstBusID = buses[0]!
let earliestPossible = (100000000000000 / firstBusID) * firstBusID + firstBusID
let winner = stride(from: earliestPossible, to: Int.max, by: firstBusID).lazy.first { timestamp in
    if timestamp % (firstBusID * 10000000) == 0 { print(timestamp) }
    return buses.enumerated().reduce(true) {
        guard let busID = $1.1 else { return $0 }
        return $0 && (((timestamp + $1.0) % busID) == 0)
    }
}
print("winner: \(winner)")

