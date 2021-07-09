import Foundation

let n = 3
let k = 3
var graph = [[1, 0, 2], [0, 0, 0], [3, 0, 0]] // 전체 보드 정보를 담는 리스트
var data = [[Int]]()  // 바이러스에 대한 정보를 담는 리스트

for i in 0...n - 1 {
    for j in 0...n - 1 {
        // 해당 위치에 바이러스가 존재하는 경우
        if graph[i][j] != 0 {
            // (바이러스 종류, 시간, 위치 X, 위치 Y) 삽입
            data.append([graph[i][j], 0, i, j])
        }
    }
}

// 정렬 이후에 큐로 옮기기 (낮은 번호의 바이러스가 먼저 증식하므로)
data.sort(by: { $0.first! < $1.first! })
var queue = data

let targetS = 2
let targetX = 3
let targetY = 2

// 바이러스가 퍼져나갈 수 있는 4가지의 위치
let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

// 너비 우선 탐색(BFS) 진행
while !queue.isEmpty {
    let q = queue.removeFirst()
    let virus = q[0]
    let s = q[1]
    let x = q[2]
    let y = q[3]
    
    // 정확히 s초가 지나거나, 큐가 빌 때까지 반복
    if s == targetS {
        break
    }
    // 현재 노드에서 주변 4가지 위치를 각각 확인
    for i in 0...3 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        // 해당 위치로 이동할 수 있는 경우
        if 0 <= nx && nx < n && 0 <= ny && ny < n {
            // 아직 방문하지 않은 위치라면, 그 위치에 바이러스 넣기
            if graph[nx][ny] == 0 {
                graph[nx][ny] = virus
                queue.append([virus, s + 1, nx, ny])
            }
        }
    }
}

print(graph[targetX - 1][targetY - 1])
