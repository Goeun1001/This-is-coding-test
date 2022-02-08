import Foundation

public struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        buildHeap()
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    func peek() -> Element? {
        elements.first
    }
    
    mutating public func buildHeap() {
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil // 1
        }
        if index == elements.count - 1 {
            return elements.removeLast() // 2
        } else {
            elements.swapAt(index, elements.count - 1) // 3
            defer {
                siftDown(from: index) // 5
                siftUp(from: index)
            }
            return elements.removeLast() // 4
        }
    }
    
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        if sort(element, elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        return nil
    }
}

let INF = 10000 // 무한을 의미하는 값

// 노드의 개수, 간선의 개수를 입력받기
let n = 6
let m = 11
let start = 1
// 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트를 만들기
let graph = [[], [[2, 2], [3, 5], [4, 1]], [[3, 3], [4, 2]], [[2, 3], [6, 5]], [[3, 3], [5, 1]], [[3, 1], [6, 2]], []]
// 최단 거리 테이블을 모두 무한으로 초기화
var distance = Array(repeating: INF, count: n + 1)

func dijkstra(start: Int) {
    // 시작 노드에 대해서 초기화
    distance[start] = 0
    // 시작 노드로 가기 위한 최단 경로는 0으로 설정하여, 큐에 삽입
    var queue = Heap(sort: { $0.first! < $1.first! }, elements: [[Int]]())
    queue.insert([0, start])

    while !queue.isEmpty { // 큐가 비어있지 않다면
        let value = queue.remove()!
        let dist = value[0]
        let now = value[1]
        // 현재 노드가 이미 처리된 적이 있는 노드라면 무시
        if distance[now] < dist {
            continue
        }
        // 현재 노드와 연결된 다른 인접한 노드들을 확인
        for i in graph[now] {
            let cost = dist + i[1]
            // 현재 노드를 거쳐서, 다른 노드로 이동하는 거리가 더 짧은 경우
            if cost < distance[i[0]] {
                distance[i[0]] = cost
                queue.insert([cost, i[0]])
            }
        }

    }
}

// 다익스트라 알고리즘을 수행
dijkstra(start: start)

// 모든 노드로 가기 위한 최단 거리를 출력
for i in 1...n {
    // 도달할 수 없는 경우, 무한(INFINITY)이라고 출력
    if distance[i] == INF {
        print("INFINITY")
    } else {
        // 도달할 수 있는 경우 거리를 출력
        print(distance[i])
    }
}
