import Foundation

let INF = 10000001 // 무한을 의미하는 값

// 노드의 개수, 간선의 개수를 입력받기
let n = Int(readLine()!)!
let m = Int(readLine()!)!
// 2차원 리스트(그래프 표현)를 만들고, 모든 값을 무한으로 초기화
var graph = Array(repeating: Array(repeating: INF, count: n + 1), count: n + 1)

// 자기 자신에서 자기 자신으로 가는 비용은 0으로 초기화
for a in 1...n {
    graph[a][a] = 0
}

// 각 간선에 대한 정보를 입력 받아, 그 값으로 초기화
for _ in 1...m {
    // A에서 B로 가는 비용은 C라고 설정
    let n = readLine()!
    let array = n.components(separatedBy: " ").map { Int($0)! }
    graph[array[0]][array[1]] = min(graph[array[0]][array[1]], array[2])
}

// 점화식에 따라 플로이드 워셜 알고리즘을 수행
for k in 1...n {
    for a in 1...n {
        for b in 1...n {
            graph[a][b] = min(graph[a][b], graph[a][k] + graph[k][b])
        }
    }
}

// 수행된 결과를 출력
for a in 1...n {
    for b in 1...n {
        // 도달할 수 없는 경우, 무한(INFINITY)이라고 출력
        if graph[a][b] == INF {
            print(0, terminator: " ")
        } else {
            // 도달할 수 있는 경우 거리를 출력
            print(graph[a][b], terminator: " ")
        }
    }
    print()
}
