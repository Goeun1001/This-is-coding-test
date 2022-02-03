import Foundation

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

let v = 7
let e = 9
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: v + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...v {
    parent[i] = i
}

// Union 연산을 각각 수행
var edges = [[1, 2, 29], [1, 5, 75], [2, 3, 35], [2, 6, 34], [3, 4, 7], [4, 6, 23], [4, 7, 13], [5, 6, 53], [6, 7, 25]]

var result = 0

// 간선을 비용순으로 정렬
edges.sort(by: { $0.last! < $1.last! })

// 간선을 하나씩 확인하며
for edge in edges {
    let a = edge[0]
    let b = edge[1]
    let cost = edge[2]
    // 사이클이 발생하지 않는 경우에만 집합에 포함
    if findParent(parent: &parent, x: a) != findParent(parent: &parent, x: b) {
        union(parent: &parent, a: a, b: b)
        result += cost
    }
}

print(result)
