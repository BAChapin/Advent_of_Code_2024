import Foundation

public struct Day2: SolutionEngine {
    
    public var input: String = ""
    public var lines: [String] = []
    
    public init() {
        do {
            try getInput("day2")
            processInput()
        } catch {
            input = ""
        }
    }
    
    public func partOne() {
        var safeReports: Int = 0
        var processedLines: [[Int]] = []
        
        processedLines = lines.map {
            let splitLines = $0.split(separator: " ")
            return splitLines.compactMap { Int($0) }
        }
        
        for report in processedLines {
            if checkReportSafety(report) {
                safeReports += 1
            }
        }
        
        print("--- Safe Reports:", safeReports)
    }
    
    public func partTwo() {
        var safeReports: Int = 0
        var processedLines: [[Int]] = []
        
        processedLines = lines.map {
            let splitLines = $0.split(separator: " ")
            return splitLines.compactMap { Int($0) }
        }
        
        for report in processedLines {
            if checkReportSafety(report) {
                safeReports += 1
            } else if checkReportSafetyWithTolerance(report) {
                safeReports += 1
            }
        }
        
        print("--- Safe Reports:", safeReports)
    }
    
    func checkReportSafety(_ report: [Int]) -> Bool {
        // Check increasing/decreasing
        let sortedReport = report.sorted()
        let isAscending = sortedReport == report
        let isDescending = sortedReport.reversed() == report
        
        if isAscending || isDescending {
            // Check levels
            for index in 1..<report.count {
                let levelForIndex = abs(report[index] - report[index - 1])
                if levelForIndex < 1 || levelForIndex > 3 {
                    return false
                }
            }
            
            return true
        }
        
        return false
    }
    
    func checkReportSafetyWithTolerance(_ report: [Int]) -> Bool {
        for index in 0..<report.count {
            var newReport = report
            newReport.remove(at: index)
            if checkReportSafety(newReport) {
                return true
            }
        }
        
        return false
    }
}
