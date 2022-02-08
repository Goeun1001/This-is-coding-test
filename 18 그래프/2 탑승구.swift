import Foundation

// 내 풀이
//let G = 4
//let P = 6
//let array = [2, 2, 3, 3, 4, 4] // 3
let G = 4
let P = 3
let array = [4, 1, 1] // 2

var result = Set<Int>()

outer: for i in array {
    if result.contains(i) {
        var i = i
        while i > 0 { // 4가 2개라면 하나는 -1씩 해도 되니까!
            if result.contains(i) {
                i -= 1
                if i == 0 { // 만약 파킹이 불가능하다면
                    break outer
                }
            } else {
                result.insert(i)
                i = 0
            }
        }
    } else {
        result.insert(i)
    }
}

print(result.count)

// 책 풀이

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

let g = 4
let p = 3
// 부모 테이블 초기화하기
var parent = Array(repeating: 0, count: g + 1)

// 부모 테이블상에서, 부모를 자기 자신으로 초기화
for i in 1...g {
    parent[i] = i
}

var res = 0
for i in array {
    let data = findParent(parent: &parent, x: i)

    if data == 0 { // 현재 루트가 0이라면, 종료
        break
    }
    union(parent: &parent, a: data, b: data - 1) // 그렇지 않다면 바로 왼쪽의 집합과 합치기
    res += 1
}

print(res)
