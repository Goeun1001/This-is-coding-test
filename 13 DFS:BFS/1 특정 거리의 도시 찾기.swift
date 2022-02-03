import Foundation

// 책 풀이
// 도시의 개수, 도로의 개수, 거리 정보, 출발 도시 번호
let arr = readLine()!.split(separator: " ").map { Int($0)! }
let n = arr[0]
let m = arr[1]
let k = arr[2]
let x = arr[3]

var graph = Array(repeating: [Int](), count: n + 1)

for _ in 0..<m {
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    graph[arr[0]].append(arr[1])
}

// 모든 도시에 대한 최단 거리 초기화
var distance = Array(repeating: -1, count: n + 1)
distance[x] = 0 // 출발 도시까지의 거리는 0으로 설정

// 너비 우선 탐색(BFS) 수행
var q = [x]
while !q.isEmpty {
    let now = q.removeFirst()
    // 현재 도시에서 이동할 수 있는 모든 도시를 확인
    for nextNode in graph[now] {
        if distance[nextNode] == -1 {
            // 최단 거리 갱신
            distance[nextNode] = distance[now] + 1
            q.append(nextNode)
        }
    }
}
// 최단 거리가 K인 모든 도시의 번호를 오름차순으로 출력
var check = false
for i in 1...n {
    if distance[i] == k {
        print(i)
        check = true
    }
}

// 만약 최단 거리가 K인 도시가 없다면, -1 출력
if check == false {
    print(-1)
}

//print(distance)
