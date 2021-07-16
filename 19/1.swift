import Foundation

// 책 풀이
let INF = 10000000000000 // 무한을 의미하는 값으로 10억을 설정
//# 맵의 크기 N 입력
let n = Int(readLine()!)!

// 전체 모든 칸에 대한 정보 입력
var array = [[Int]]()
for _ in 1...n {
    array.append(readLine()!.components(separatedBy: " ").map { Int($0)! })
}
// 아기 상어의 현재 크기 변수와 현재 위치 변수
var now_size = 2
var now_x = 0
var now_y = 0

// 아기 상어의 시작 위치를 찾은 뒤에 그 위치엔 아무것도 없다고 처리
for i in 0...n - 1 {
    for j in 0...n - 1 {
        if array[i][j] == 9 {
            now_x = i
            now_y = j
            array[now_x][now_y] = 0
        }
    }
}

let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

// 모든 위치까지의 '최단 거리만' 계산하는 BFS 함수
func bfs() -> [[Int]] {
    // 값이 -1이라면 도달할 수 없다는 의미 (초기화)
    var dist = Array(repeating: Array(repeating: -1, count: n), count: n)
    // 시작 위치는 도달이 가능하다고 보며 거리는 0
    var q = [[now_x, now_y]]
    dist[now_x][now_y] = 0

    while !q.isEmpty {
        let pop = q.removeFirst()
        let x = pop[0]
        let y = pop[1]

        for i in 0...3 {
            let nx = x + dx[i]
            let ny = y + dy[i]

            if 0 <= nx && nx < n && 0 <= ny && ny < n {
                // 자신의 크기보다 작거나 같은 경우에 지나갈 수 있음
                if dist[nx][ny] == -1 && array[nx][ny] <= now_size {
                    dist[nx][ny] = dist[x][y] + 1
                    q.append([nx, ny])
                }
            }
        }
    }
    // 모든 위치까지의 최단 거리 테이블 반환
    return dist
}

// 최단 거리 테이블이 주어졌을 때, 먹을 물고기를 찾는 함수
func find(_ dist: [[Int]]) -> [Int]? {
    var x = 0
    var y = 0
    var min_dist = INF
    for i in 0...n - 1 {
        for j in 0...n - 1 {
            // 도달이 가능하면서 먹을 수 있는 물고기일 때
            if dist[i][j] != -1 && 1 <= array[i][j] && array[i][j] < now_size {
                if dist[i][j] < min_dist {
                    x = i
                    y = j
                    min_dist = dist[i][j]
                }
            }
        }
    }

    if min_dist == INF { // 먹을 수 있는 물고기가 없는 경우
        return nil
    } else {
        return [x, y, min_dist] // 먹을 물고기의 위치와 최단 거리
    }
}

var result = 0 // 최종 답안
var ate = 0 // 현재 크기에서 먹은 양

while true {
    // 먹을 수 있는 물고기의 위치 찾기
    let value = find(bfs())
    // # 먹을 수 있는 물고기가 없는 경우, 현재까지 움직인 거리 출력
    if value == nil {
        print(result)
        break
    } else {
        // 현재 위치 갱신 및 이동 거리 변경
        now_x = value![0]
        now_y = value![1]
        result += value![2]
        // 먹은 위치에는 이제 아무것도 없도록 처리
        array[now_x][now_y] = 0
        ate += 1
        //  자신의 현재 크기 이상으로 먹은 경우, 크기 증가
        if ate >= now_size {
            now_size += 1
            ate = 0
        }
    }
}
