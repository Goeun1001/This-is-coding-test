import Foundation

// 내 풀이
let N = 6
var higher = Array(repeating: [Int](), count: N + 1)
var lower = Array(repeating: [Int](), count: N + 1)
var result = 0

let students = [[1, 5], [3, 4], [4, 2], [4, 6], [5, 2], [5, 4]]

for i in students {
    higher[i[0]].append(i[1]) // i[1]이 i[0]보다 높음
    lower[i[1]].append(i[0]) // i[1]이 i[0]보다 높음
}

for i in 0...lower.count - 1 {
    for j in lower[i] {
        for k in lower[j] {
            if !lower[i].contains(k) { lower[i].append(k) }
        }
    }
}

for i in 0...higher.count - 1 {
    for j in higher[i] {
        for k in higher[j] {
            if !higher[i].contains(k) { higher[i].append(k) }
        }
    }
}

for i in 1...N {
    if higher[i].count + lower[i].count == N - 1 {
        result += 1
    }
}

print(result)

// 책 풀이.. 플로이드네
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
    graph[array[0]][array[1]] = 1
}

// 점화식에 따라 플로이드 워셜 알고리즘을 수행
for k in 1...n {
    for a in 1...n {
        for b in 1...n {
            graph[a][b] = min(graph[a][b], graph[a][k] + graph[k][b])
        }
    }
}

result = 0
// 각 학생을 번호에 따라 한 명씩 확인하며 도달 가능한지 체크
for i in 1...n {
    var count = 0
    for j in 1...n {
        if graph[i][j] != INF || graph[j][i] != INF {
            count += 1
        }
    }
    if count == n {
        result += 1
    }
}
print(result)
