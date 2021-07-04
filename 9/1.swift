import Foundation

let INF = 10000 // 무한을 의미하는 값

// 노드의 개수, 간선의 개수를 입력받기
let n = 6
let m = 11
let start = 1
// 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트를 만들기
let graph = [[], [[2, 2], [3, 5], [4, 1]], [[3, 3], [4, 2]], [[2, 3], [6, 5]], [[3, 3], [5, 1]], [[3, 1], [6, 2]], []]
var visited = Array(repeating: false, count: n + 1)
// 최단 거리 테이블을 모두 무한으로 초기화
var distance = Array(repeating: INF, count: n + 1)

// 방문하지 않은 노드 중에서, 가장 최단 거리가 짧은 노드의 번호를 반환
func getSmallestNode() -> Int {
    var minValue = INF
    var index = 0 // 가장 최단 거리가 짧은 노드(인덱스)
    for i in 1...n {
        if distance[i] < minValue && !visited[i] {
            minValue = distance[i]
            index = i
        }
    }
    return index
}

func dijkstra(start: Int) {
    // 시작 노드에 대해서 초기화
    distance[start] = 0
    visited[start] = true
    for j in graph[start] {
        distance[j[0]] = j[1]
    }
    // 시작 노드를 제외한 전체 n - 1개의 노드에 대해 반복
    for _ in 0...n - 2 {
        // 현재 최단 거리가 가장 짧은 노드를 꺼내서, 방문 처리
        let now = getSmallestNode()
        visited[now] = true
        // 현재 노드와 연결된 다른 노드를 확인
        for j in graph[now] {
            let cost = distance[now] + j[1]
            // 현재 노드를 거쳐서 다른 노드로 이동하는 거리가 더 짧은 경우
            if cost < distance[j[0]] {
                distance[j[0]] = cost
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
