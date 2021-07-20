import Foundation

let LOG = 21 // 2^20 = 1,000,000

let n = Int(readLine()!)!

var parent = Array(repeating: Array(repeating: 0, count: LOG), count: n + 1) // 부모 노드 정보
var d = Array(repeating: 0, count: n + 1) // 각 노드까지의 깊이
var c = Array(repeating: false, count: n + 1) // 각 노드의 깊이가 계산되었는지 여부
var graph = Array(repeating: [Int](), count: n + 1) // 그래프(graph) 정보

for _ in 0..<n - 1 {
    let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = arr[0]
    let b = arr[1]
    graph[a].append(b)
    graph[b].append(a)
}

// 루트 노드부터 시작하여 깊이(depth)를 구하는 함수
func dfs(x: Int, depth: Int) {
    c[x] = true
    d[x] = depth
    for y in graph[x] {
        if c[y] { // 이미 깊이를 구했다면 넘기기
            continue
        }
        parent[y][0] = x
        dfs(x: y, depth: depth + 1)
    }
}

// 전체 부모 관계를 설정하는 함수
func set_parent() {
    dfs(x: 1, depth: 0) // 루트 노드는 1번 노드
    for i in 1...LOG - 1 {
        for j in 1...n {
            parent[j][i] = parent[parent[j][i - 1]][i - 1]
        }
    }
}

// A와 B의 최소 공통 조상을 찾는 함수
func lca(a: Int, b: Int) -> Int {
    var a = a
    var b = b
    // b가 더 깊도록 설정
    if d[a] > d[b] {
        let temp = a
        a = b
        b = temp
    }
    // 먼저 깊이(depth)가 동일하도록
    for i in stride(from: LOG - 1, to: -1, by: -1) {
        if d[b] - d[a] >= (1 << i) {
            b = parent[b][i]
        }
    }
    // 부모가 같아지도록
    if a == b {
        return a
    }
    for i in stride(from: LOG - 1, to: -1, by: -1) {
        // 조상을 향해 거슬러 올라가기
        if parent[a][i] != parent[b][i] {
            a = parent[a][i]
            b = parent[b][i]
        }
    }

    // 이후에 부모가 찾고자 하는 조상
    return parent[a][0]
}

set_parent()

let m = Int(readLine()!)!

for _ in 1...m {
    let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = arr[0]
    let b = arr[1]
    print(lca(a: a, b: b))
}
