import Foundation

public struct PriorityQueue<Element: Equatable> {
    private var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var peek: Element? {
        return elements.first
    }
    
    public mutating func enqueue(element: Element) -> Bool {
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> Element? {
        isEmpty ? nil : elements.removeFirst()
    }
    
}


// 노드의 개수와 간선의 개수를 입력 받기
let v = 5
//# 모든 노드에 대한 진입차수는 0으로 초기화
var indegree = Array(repeating: 0, count: v + 1)
// 각 노드에 연결된 간선 정보를 담기 위한 연결 리스트 초기화
var graph = [[], [2, 3, 4], [], [4, 5], [], []] // 정점 A에서 B로 이동 가능
// 각 강의 시간
let time = [0, 10, 10, 4, 4, 3]
var result = time

// 방향 그래프의 모든 간선 정보를 입력 받기
for i in 1...v {
    for j in graph[i] {
        // 진입 차수를 1 증가
        indegree[j] += 1
    }
}

// 위상 정렬 함수
func topology_sort() {
    var queue = PriorityQueue<Int>(sort: { $0 < $1 })
    
    // 처음 시작할 때는 진입차수가 0인 노드를 큐에 삽입
    for i in 1...v {
        if indegree[i] == 0 {
            queue.enqueue(element: i)
        }
    }
    
    // 큐가 빌 때까지 반복
    while !queue.isEmpty {
        // 큐에서 원소 꺼내기
        let now = queue.dequeue()!
        // 해당 원소와 연결된 노드들의 진입차수에서 1 빼기
        for i in graph[now] {
            result[i] = max(result[i], result[now] + time[i])
            indegree[i] -= 1
            // 새롭게 진입차수가 0이 되는 노드를 큐에 삽입
            if indegree[i] == 0 {
                queue.enqueue(element: i)
            }
        }
    }
    // 위상 정렬을 수행한 결과 출력
    for i in 1...v {
        print(result[i])
    }
}

topology_sort()
