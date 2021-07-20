import Foundation

let n = Int(readLine()!)!

var parent = Array(repeating: 0, count: n + 1) // 부모 노드 정보
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
        parent[y] = x
        dfs(x: y, depth: depth + 1)
    }
}

// A와 B의 최소 공통 조상을 찾는 함수
func lca(a: Int, b: Int) -> Int {
    var a = a
    var b = b
    // 먼저 깊이(depth)가 동일하도록
    while d[a] != d[b] {
        if d[a] > d[b] {
            a = parent[a]
        } else {
            b = parent[b]
        }
    }
    // 노드가 같아지도록
    while a != b {
        a = parent[a]
        b = parent[b]
    }
    return a
}

dfs(x: 1, depth: 0) // 루트 노드는 1번 노드

let m = Int(readLine()!)!

for _ in 1...m {
    let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = arr[0]
    let b = arr[1]
    print(lca(a: a, b: b))
}
