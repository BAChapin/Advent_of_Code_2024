import Foundation

public func calculateTimeOutput(elapsedTime: TimeInterval) -> String {
    if elapsedTime >= 60 {
        let minutes = floor(elapsedTime / 60)
        let seconds = round(elapsedTime.truncatingRemainder(dividingBy: 60))
        return "\(minutes) m \(seconds) s"
    } else if elapsedTime >= 1 {
        let seconds = floor(elapsedTime)
        let milliseconds = round((elapsedTime * 100000)).truncatingRemainder(dividingBy: 100000) / 100
        return "\(seconds) s \(milliseconds) ms"
    } else {
        let milliseconds = round(elapsedTime * 100000) / 100
        return "\(milliseconds) ms"
    }
}

public func splitArray<T>(inputArray: [T], _ areEqual: (T, T) -> Bool) -> [[T]] {
    var result: [[T]] = []
    
    for element in inputArray {
        if let lastArray = result.last, let lastElement = lastArray.last, areEqual(element, lastElement) {
            result[result.count - 1].append(element)
        } else {
            result.append([element])
        }
    }
    
    return result
}
