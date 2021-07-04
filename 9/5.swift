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

let INF = 10000 // 무한을 의미하는 값

// 노드의 개수, 간선의 개수를 입력받기
let n = 3
let m = 2
let start = 1
// 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트를 만들기
let graph = [[], [[2, 4], [3, 2]], [], []]
var visited = Array(repeating: false, count: n + 1)
// 최단 거리 테이블을 모두 무한으로 초기화
var distance = Array(repeating: INF, count: n + 1)

func dijkstra(start: Int) {
    // 시작 노드에 대해서 초기화
    distance[start] = 0
    visited[start] = true
    // 시작 노드로 가기 위한 최단 경로는 0으로 설정하여, 큐에 삽입
    var queue = PriorityQueue(sort: { $0.first! < $1.first! }, elements: [[Int]]())
    queue.enqueue(element: [0, start])

    while !queue.isEmpty { // 큐가 비어있지 않다면
        let value = queue.dequeue()!
        print(value)
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
                queue.enqueue(element: [cost, i[0]])
            }
        }

    }
}

// 다익스트라 알고리즘을 수행
dijkstra(start: start)

// 도달할 수 있는 노드 중에서, 가장 멀리 있는 노드와의 최단 거리
var count = 0
var max_distance = 0
for d in distance {
    // 도달할 수 있는 노드인 경우
    if d != INF {
        count += 1
        max_distance = max(max_distance, d)
    }
}

// 시작 노드는 제외해야 하므로 count - 1을 출력
print(count - 1, max_distance)
