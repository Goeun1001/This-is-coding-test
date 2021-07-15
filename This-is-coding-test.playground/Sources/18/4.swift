import Foundation

// 책 풀이.. 이게 왜 크루스칼이세용?
// 특정 원소가 속한 집합을 찾기
func findParent(parent: inout [Int], x: Int) -> Int {
    // 루트 노드가 아니라면, 루트 노드를 찾을 때까지 재귀적으로 호출
    if parent[x] != x {
        parent[x] = findParent(parent: &parent, x: parent[x])
    }
    return parent[x]
}
// 두 원소가 속한 집합을 합치기
func union(parent: inout [Int], a: Int, b: Int) {
    let a = findParent(parent: &parent, x: a)
    let b = findParent(parent: &parent, x: b)
    if a < b {
        parent[b] = a
    } else {
        parent[a] = b
    }
}


let N = Int(readLine()!)!
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: N + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...N {
    parent[i] = i
}

// Union 연산을 각각 수행
var edges = [[Int]]()
var result = 0

var x = [[Int]]()
var y = [[Int]]()
var z = [[Int]]()

for i in 1...N {
    let a = readLine()!
    let array = a.components(separatedBy: " ").map { Int($0)! }
    x.append([array[0], i])
    y.append([array[1], i])
    z.append([array[2], i])
}

x.sort(by: { $0.first! < $1.first! })
y.sort(by: { $0.first! < $1.first! })
z.sort(by: { $0.first! < $1.first! })

// 인접한 노드들로부터 간선 정보를 추출하여 처리
for i in 0...N - 2 {
    // 비용순으로 정렬하기 위해서 튜플의 첫 번째 원소를 비용으로 설정
    edges.append([x[i + 1][0] - x[i][0], x[i][1], x[i + 1][1]])
    edges.append([y[i + 1][0] - y[i][0], y[i][1], y[i + 1][1]])
    edges.append([z[i + 1][0] - z[i][0], z[i][1], z[i + 1][1]])
}

// 간선을 비용순으로 정렬
edges.sort(by: { $0.first! < $1.first! })

// 간선을 하나씩 확인하며
for edge in edges {
    let cost = edge[0]
    let a = edge[1]
    let b = edge[2]

    // 사이클이 발생하지 않는 경우에만 집합에 포함
    if findParent(parent: &parent, x: a) != findParent(parent: &parent, x: b) {
        union(parent: &parent, a: a, b: b)
        result += cost
    }
}

print(result)
