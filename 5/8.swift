import Foundation

// DFS 함수 정의
func dfs(graph: [[Int]], v: Int, visited: inout [Bool]) {
    print(v, separator: " ", terminator: " ")
    visited[v] = true
    for i in graph[v] {
        if !visited[i] {
            dfs(graph: graph, v: i, visited: &visited)
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

//# 각 노드가 방문된 정보를 리스트 자료형으로 표현(1차원 리스트)
var visited = Array(repeating: false, count: 9)

// 정의된 DFS 함수 호출
dfs(graph: graph, v: 1, visited: &visited)
