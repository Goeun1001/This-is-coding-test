import Foundation

// 원래는 다익스트라로 풀어야되는데 플루이드로 푼 편... ^^
let INF = 10000 // 무한을 의미하는 값

// 노드의 개수
let n = 6
// 2차원 리스트(그래프 표현)를 만들고, 모든 값을 무한으로 초기화
var graph = Array(repeating: Array(repeating: INF, count: n + 1), count: n + 1)

// 자기 자신에서 자기 자신으로 가는 비용은 0으로 초기화
for a in 1...n {
    graph[a][a] = 0
}

// 각 간선에 대한 정보를 입력 받아, 그 값으로 초기화
let edge = [[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]

for e in edge {
    graph[e[0]][e[1]] = 1
    graph[e[1]][e[0]] = 1
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
var number = n
var result = 0
var count = 0

for i in 1...n {
    if graph[1][i] != INF {
        result = max(result, graph[1][i])
    }
}

for i in 1...n {
    if graph[1][i] == result {
        number = min(number, i)
        count += 1
    }
}

print(number, result, count)
