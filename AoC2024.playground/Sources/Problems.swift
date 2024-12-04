import Foundation

public enum Problems {
    case day1
    
    private var engine: SolutionEngine {
        switch self {
        case .day1: return Day1()
        }
    }
    
    public func run(_ times: Int = 1) {
        let (start, end) = runPartOne(times)
        let endPartTwo = runPartTwo(times, start: end)
        
        print("Function Runs:", times)
        let totalElapsedTime = endPartTwo.timeIntervalSince1970 - start.timeIntervalSince1970
        print("Total Elapsed Time:", "\(calculateTimeOutput(elapsedTime: totalElapsedTime))")
        print(String(repeating: "*", count: 80))
    }
    
    private func runPartOne(_ times: Int) -> (start: Date, end: Date) {
        let accessoryString = String(repeating: "*", count: 35)
        let title = " Part One "
        let start = Date()
        
        print(accessoryString + title + accessoryString)
        print("Function Started:", start)
        for _ in 0..<times {
            engine.partOne()
        }
        
        let end = Date()
        print("Function Ended:", end)
        let totalElapsedTime = end.timeIntervalSince1970 - start.timeIntervalSince1970
        print("Total Elapsed Time:", "\(calculateTimeOutput(elapsedTime: totalElapsedTime))")
        print("Average Execution Time:", "\(calculateTimeOutput(elapsedTime: totalElapsedTime / Double(times)))")
        
        return (start, end)
    }
    
    private func runPartTwo(_ times: Int, start: Date) -> Date {
        let accessoryString = String(repeating: "*", count: 35)
        let title = " Part Two "
        
        print(accessoryString + title + accessoryString)
        print("Function Started:", start)
        for _ in 0..<times {
            engine.partTwo()
        }
        
        let end = Date()
        print("Function Ended:", end)
        let totalElapsedTime = end.timeIntervalSince1970 - start.timeIntervalSince1970
        print("Total Elapsed Time:", "\(calculateTimeOutput(elapsedTime: totalElapsedTime))")
        print("Average Execution Time:", "\(calculateTimeOutput(elapsedTime: totalElapsedTime / Double(times)))")
        print(String(repeating: "*", count: 80))
        
        return end
    }
}
