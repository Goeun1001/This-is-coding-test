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

let v = 3
let e = 3
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: v + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...v {
    parent[i] = i
}

var cycle = false // 사이클 발생 여부

// Union 연산을 각각 수행
let union = [[1, 2], [1, 3], [2, 3]]

for _ in 0...e - 1 {
    for u in union {
        // 사이클이 발생한 경우 종료
        if findParent(parent: &parent, x: u[0]) == findParent(parent: &parent, x: u[1]) {
            cycle = true
            break
        } else {
            // 사이클이 발생하지 않았다면 합집합(Union) 연산 수행
            union(parent: &parent, a: u[0], b: u[1])
        }
    }
}

if cycle {
    print("사이클이 발생했습니다.")
} else {
    print("사이클이 발생하지 않았습니다.")
}
