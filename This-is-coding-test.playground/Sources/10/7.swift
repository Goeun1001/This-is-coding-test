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

let n = 7
let m = 8
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: n + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...n {
    parent[i] = i
}

let problems = [[0, 1, 3], [1, 1, 7], [0, 7, 6], [1, 7, 1], [0, 3, 7], [0, 4, 2], [0, 1, 1], [1, 1, 1]]

for problem in problems {
    if problem[0] == 1 {
        if findParent(parent: &parent, x: problem[1]) == problem[2] {
            print("YES")
        } else {
            print("NO")
        }
    } else {
        union(parent: &parent, a: problem[1], b: problem[2])
    }
}

