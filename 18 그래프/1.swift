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

let n = 5
let m = 4
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: n + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...n {
    parent[i] = i
}
// Union 연산을 각각 수행
let union = [[1, 2], [1, 4], [1, 5], [2, 1], [2, 3], [2, 4], [3, 2], [4, 1], [4, 2], [5, 1]]
for _ in 0...m - 1 {
    for u in union {
        union(parent: &parent, a: u[0], b: u[1])
    }
}

let plan = [2, 3, 4, 3]

var result = true
// 여행 계획에 속하는 모든 노드의 루트가 동일한지 확인
for i in 0...m - 2 {
    if findParent(parent: &parent, x: plan[i]) != findParent(parent: &parent, x: plan[i + 1]) {
        result = false
    }
}

// 여행 계획에 속하는 모든 노드가 서로 연결되어 있는지(루트가 동일한지) 확인
if result {
    print("YES")
} else {
    print("NO")
}
