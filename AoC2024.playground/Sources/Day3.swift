import Foundation

public struct Day3: SolutionEngine {
    
    public var input: String = ""
    public var lines: [String] = []
    
    public init() {
        do {
            try getInput("day3")
            processInput()
        } catch {
            input = ""
        }
    }
    
    public func partOne() {
        let instances = getInstances(with: input)
        let values = instances.compactMap { extractNumbers(from: $0) }
        
        let results = values.reduce(0) { $0 + ($1.left * $1.right) }
        print("--- Multiplied Results:", results)
    }
    
    public func partTwo() {
        let results = processMemory()
        print("--- Multiplied Results:", results)
    }
    
    func getInstances(with input: String) -> [String] {
        let pattern = #"mul\((\d{1,3}),(\d{1,3})\)"#
        var instances: [String] = []
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
            
            for match in matches {
                if let range = Range(match.range, in: input) {
                    let matchString = String(input[range])
                    instances.append(matchString)
                }
            }
        }
        
        return instances
    }
    
    func findInstructions() -> [(instruction: String, location: Int)] {
        let pattern = #"don't\(\)|do\(\)"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        
        let instructionSet = matches.compactMap {
            if let range = Range($0.range, in: input) {
                return (String(input[range]), $0.range.location)
            }
            return nil
        }
        
        return instructionSet
    }
    
    func extractNumbers(from string: String) -> (left: Int, right: Int)? {
        let pattern = #"\d{1,3}"#
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: []),
           let matches = regex.matches(in: string, range: NSRange(string.startIndex..., in: string)) as [NSTextCheckingResult]? {
            
            if matches.count == 2,
               let firstRange = Range(matches[0].range, in: string),
               let secondRange = Range(matches[1].range, in: string) {
                guard let firstNumber = Int(string[firstRange]),
                      let secondNumber = Int(string[secondRange]) else { return nil }
                
                return (left: firstNumber, right: secondNumber)
            }
        }
        
        return nil
    }
    
    func processMemory() -> Int {
        let mulPattern = #"mul\((\d{1,3}),(\d{1,3})\)"# // Matches valid mul(X,Y)
        let controlPattern = #"don't\(\)|do\(\)"# // Matches control instructions
        var enabled = true // Initially, mul instructions are enabled
        var sum = 0
        
        // Combine both patterns into one
        let combinedPattern = "\(mulPattern)|\(controlPattern)"
        
        // Create regex
        guard let regex = try? NSRegularExpression(pattern: combinedPattern, options: []) else {
            return 0
        }
        
        // Find all matches
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
        
        for match in matches {
            // Extract the matched substring
            if let range = Range(match.range, in: input) {
                let matchedString = String(input[range])
                
                // Check for control instructions
                if matchedString == "don't()" {
                    enabled = false
                } else if matchedString == "do()" {
                    enabled = true
                }
                
                // Check for valid mul instructions
                else if enabled, let mulMatch = try? NSRegularExpression(pattern: mulPattern, options: []).firstMatch(in: matchedString, range: NSRange(matchedString.startIndex..., in: matchedString)) {
                    if let xRange = Range(mulMatch.range(at: 1), in: matchedString),
                       let yRange = Range(mulMatch.range(at: 2), in: matchedString) {
                        let x = Int(matchedString[xRange]) ?? 0
                        let y = Int(matchedString[yRange]) ?? 0
                        sum += x * y
                    }
                }
            }
        }
        
        return sum
    }
}
