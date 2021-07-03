import Foundation

// BFS 함수 정의
func bfs(graph: [[Int]], start: Int, visited: inout [Bool]) {
    var queue = [start]
    // 현재 노드를 방문 처리
    visited[start] = true
    // 큐가 빌 때까지 반복
    while !queue.isEmpty {
        // 큐에서 하나의 원소를 뽑아 출력
        let v = queue.removeFirst()
        print(v, separator: " ", terminator: " ")

        // 해당 원소와 연결된, 아직 방문하지 않은 원소들을 큐에 삽입
        for i in graph[v] {
            if !visited[i] {
                queue.append(i)
                visited[i] = true
            }
        }
    }
}

// 각 노드가 연결된 정보를 리스트 자료형으로 표현(2차원 리스트)
let graph = [
  [],
  [2, 3, 8],
  [1, 7],
  [1, 4, 5],
  [3, 5],
  [3, 4],
  [7],
  [2, 6, 8],
  [1, 7]
]

// 각 노드가 방문된 정보를 리스트 자료형으로 표현(1차원 리스트)
var visited = Array(repeating: false, count: 9)

// 정의된 BFS 함수 호출
bfs(graph: graph, start: 1, visited: &visited)
