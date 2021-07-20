import Foundation

let INF = Int(1e9) // 무한을 의미하는 값으로 10억을 설정

// 노드의 개수, 간선의 개수를 입력받기
let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = arr[0]
let m = arr[1]

// 모든 간선에 대한 정보를 담는 리스트 만들기
var edges = [(Int, Int, Int)]()
//# 최단 거리 테이블을 모두 무한으로 초기화
var distance = Array(repeating: INF, count: n + 1)

// 모든 간선 정보를 입력받기
for _ in 1...m {
    let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = arr[0]
    let b = arr[1]
    let c = arr[2]
   // a번 노드에서 b번 노드로 가는 비용이 c라는 의미
    edges.append((a, b, c))
}

func bf(_ start: Int) -> Bool {
    // 시작 노드에 대해서 초기화
    distance[start] = 0

    // 전체 n - 1번의 라운드(round)를 반복
    for i in 0...n - 1 {
        // 매 반복마다 "모든 간선"을 확인하며
        for j in 0...m - 1 {
            let cur_node = edges[j].0
            let next_node = edges[j].1
            let edge_cost = edges[j].2

            //  현재 간선을 거쳐서 다른 노드로 이동하는 거리가 더 짧은 경우
            if distance[cur_node] != INF && distance[next_node] > distance[cur_node] + edge_cost {
                distance[next_node] = distance[cur_node] + edge_cost
                // n번째 라운드에서도 값이 갱신된다면 음수 순환이 존재
                if i == n - 1 {
                    return true
                }
            }
        }
    }
    return false
}

// 벨만 포드 알고리즘을 수행
let negative_cycle = bf(1) // 1번 노드가 시작 노드

if negative_cycle {
    print("-1")
} else {
    // 1번 노드를 제외한 다른 모든 노드로 가기 위한 최단 거리를 출력
    for i in 2...n {
        // 도달할 수 없는 경우, -1을 출력
        if distance[i] == INF {
            print("-1")
        } else { // 도달할 수 있는 경우 거리를 출력
            print(distance[i])
        }
    }
}
