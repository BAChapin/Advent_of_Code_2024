import Foundation

public struct Day1: SolutionEngine {
    
    public var input: String = ""
    public var lines: [String] = []
    
    public init() {
        do {
            try getInput("day1")
            processInput()
        } catch {
            input = ""
        }
    }
    
    public func partOne() {
        var sortedData = processAndSortLines()
        var totalDistance: Int = 0
        
        for index in 0..<lines.count {
            totalDistance += abs(sortedData.right[index] - sortedData.left[index])
        }
        
        print("--- Total Distance:", totalDistance)
    }
    
    public func partTwo() {
        var sortedData = processAndSortLines()
        let countedSet = NSCountedSet(array: sortedData.right)
        var similarityScore: Int = 0
        
        for check in sortedData.left {
            
            similarityScore += (countedSet.count(for: check) * check)
        }
        
        print("--- Similarity Score:", similarityScore)
    }
    
    func processAndSortLines() -> (left: [Int], right: [Int]) {
        var leftColumn: [Int] = []
        var rightColumn: [Int] = []
        
        for line in lines {
            let splitLine = line.split(separator: "   ")
            guard let leftValue = Int(splitLine[0]), let rightValue = Int(splitLine[1]) else {
                continue
            }
            leftColumn.append(leftValue)
            rightColumn.append(rightValue)
        }
        
        leftColumn.sort()
        rightColumn.sort()
        
        return (leftColumn, rightColumn)
    }
    
}
