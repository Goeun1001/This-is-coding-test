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

let v = 6
let e = 4
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: v + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...v {
    parent[i] = i
}
// Union 연산을 각각 수행
let union = [[1, 4], [2, 3], [2, 4], [5, 6]]
for _ in 0...e - 1 {
    for u in union {
        union(parent: &parent, a: u[0], b: u[1])
    }
}
// 각 원소가 속한 집합 출력하기
print("각 원소가 속한 집합: ", terminator: "")
for i in 1...v {
    print(findParent(parent: &parent, x: i), terminator: " ")
}

print()
// 부모 테이블 내용 출력하기
print("부모 테이블: ", terminator: "")
for i in 1...v {
    print(parent[i], terminator: " ")
}
