import Foundation

// 책 풀이 !!
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

let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

// 노드의 개수를 입력받기
let n = 3

// 전체 맵 정보를 입력받기
let graph = [[5, 5, 4], [3, 9, 1], [3, 2, 7]]
// 최단 거리 테이블을 모두 무한으로 초기화
var distance = Array(repeating: Array(repeating: INF, count: n + 1), count: n + 1)
// 시작 위치는 (0, 0)
var x = 0
var y = 0
// 시작 노드로 가기 위한 비용은 (0, 0) 위치의 값으로 설정하여, 큐에 삽입
var queue = PriorityQueue(sort: { $0.first! < $1.first! }, elements: [[Int]]())
queue.enqueue(element: [graph[x][y], x, y])
distance[x][y] = graph[x][y]

// 다익스트라 알고리즘을 수행
while !queue.isEmpty {
    // 가장 최단 거리가 짧은 노드에 대한 정보를 꺼내기
    let pop = queue.dequeue()!
    let dist = pop[0]
    let x = pop[1]
    let y = pop[2]
    
    // 현재 노드가 이미 처리된 적이 있는 노드라면 무시
    if distance[x][y] < dist {
        continue
    }
    
    // 현재 노드와 연결된 다른 인접한 노드들을 확인
    for i in 0...3 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        // 맵의 범위를 벗어나는 경우 무시
        if nx < 0 || nx >= n || ny < 0 || ny >= n {
            continue
        }
        
        let cost = dist + graph[nx][ny]
        //  현재 노드를 거쳐서, 다른 노드로 이동하는 거리가 더 짧은 경우
        if cost < distance[nx][ny] {
            distance[nx][ny] = cost
            queue.enqueue(element: [cost, nx, ny])
        }
    }
}

print(distance[n - 1][n - 1])
