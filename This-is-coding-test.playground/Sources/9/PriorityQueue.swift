import Foundation

public struct PriorityQueue<Element: Equatable> {
    private var elements: [[Element]] = []
    let sort: ([Element], [Element]) -> Bool
    
    public init(sort: @escaping ([Element], [Element]) -> Bool, elements: [[Element]] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var peek: [Element]? {
        return elements.first
    }
    
    public mutating func enqueue(element: [Element]) -> Bool {
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> [Element]? {
        isEmpty ? nil : elements.removeFirst()
    }
    
}
