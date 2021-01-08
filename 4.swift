#!/usr/bin/swift

import Foundation

let s = try! String(contentsOfFile: "./4.input", encoding: .ascii)

var passports = s.components(separatedBy: "\n\n")
    .map { passport in passport.components(separatedBy: .whitespacesAndNewlines) }
    .map { passport in passport.map { pair in pair.components(separatedBy: ":") } }
    .map { passport in passport.map { pair in (pair[0], pair[1]) } }
    .map { passport in [String: String](uniqueKeysWithValues: passport) }
    .filter { passport in isValid(p: passport) }
    .count
print(passports)

func isValid(p d: [String: String]) -> Bool {
    return passport(d, hasValidValueForKey: "byr")
        && passport(d, hasValidValueForKey: "iyr")
        && passport(d, hasValidValueForKey: "eyr")
        && passport(d, hasValidValueForKey: "hgt")
        && passport(d, hasValidValueForKey: "ecl")
        && passport(d, hasValidValueForKey: "hcl")
        && passport(d, hasValidValueForKey: "pid")
}

func passport(_ d: [String: String], hasValidValueForKey k: String) -> Bool {
    switch k {
    case "byr":
        if let v = d[k], let byr = Int(v)  {
            return byr >= 1920 && byr <= 2002
        }

    case "iyr":
        if let v = d[k], let iyr = Int(v) {
            return iyr >= 2010 && iyr <= 2020
        }

    case "eyr":
        if let v = d[k], let eyr = Int(v) {
            return eyr >= 2020 && eyr <= 2030
        }

    case "hgt":
        if let hgt = d[k],  let unitIndex = hgt.index(hgt.endIndex, offsetBy: -2, limitedBy: hgt.startIndex), let hgtNum = Int(hgt.prefix(upTo: unitIndex)) {
            if hgt.hasSuffix("cm") {
                return hgtNum >= 150 && hgtNum <= 193

            } else if hgt.hasSuffix("in") {
                return hgtNum >= 59 && hgtNum <= 76
            }
        }

    case "ecl":
        if let ecl = d[k] {
            switch ecl {
            case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
                return true

            default: break
            }
        }

    case "hcl":
        if let hcl = d[k], hcl.count == 7 && hcl.hasPrefix("#") {
            let hex = hcl.suffix(6)
            return hex.reduce(true) { r, e in r && e.isHexDigit }
        }

    case "pid":
        if let pid = d[k] {
            return pid.count == 9 && pid.reduce(true, { r, e in r && e.isASCII && e.isNumber })
        }

    default:
        return false
    }

    return false
}
