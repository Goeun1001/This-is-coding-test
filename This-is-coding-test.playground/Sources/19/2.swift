import Foundation

// 책 풀이
//# 4 X 4 크기 격자에 존재하는 각 물고기의 번호(없으면 -1)와 방향 값을 담는 테이블
var array = Array(repeating: Array(repeating: [-1], count: 4), count: 4)

for i in 0...3 {
    let data = readLine()!.components(separatedBy: " ").map { Int($0)! }
    for j in 0...3 {
        // 각 위치마다 [물고기의 번호, 방향]을 저장
        array[i][j] = [data[j * 2], data[j * 2 + 1] - 1]
    }
}

// 8가지 방향에 대한 정의
let dx = [-1, -1, 0, 1, 1, 1, 0, -1]
let dy = [0, -1, -1, -1, 0, 1, 1, 1]

// 현재 위치에서 왼쪽으로 회전된 결과 반환
func turn_left(_ direction: Int) -> Int {
    return (direction + 1) % 8
}

var result = 0 // 최종 결과

// 현재 배열에서 특정한 번호의 물고기 위치 찾기
func find_fish(_ array: [[[Int]]], _ index: Int) -> (Int, Int)? {
    for i in 0...3 {
        for j in 0...3 {
            if array[i][j][0] == index {
                return (i, j)
            }
        }
    }
    return nil
}

// 모든 물고기를 회전 및 이동시키는 함수
func move_all_fishes(_ array: inout [[[Int]]], _ now_x: Int, _ now_y: Int) {
    // 1번부터 16번까지의 물고기를 차례대로 (낮은 번호부터) 확인
    for i in 1...16 {
        // 해당 물고기의 위치를 찾기
        let position = find_fish(array, i)
        if position != nil {
            let x = position!.0
            let y = position!.1
            var direction = array[x][y][1]
            // 해당 물고기의 방향을 왼쪽으로 계속 회전시키며 이동이 가능한지 확인
            for _ in 0...7 {
                let nx = x + dx[direction]
                let ny = y + dy[direction]
                if 0 <= nx && nx < 4 && 0 <= ny && ny < 4 {
                    if !(nx == now_x && ny == now_y) {
                        array[x][y][1] = direction
                        let temp = array[x][y]
                        array[x][y] = array[nx][ny]
                        array[nx][ny] = temp
                        break
                    }
                }
                direction = turn_left(direction)
            }
        }
    }
}

// 상어가 현재 위치에서 먹을 수 있는 모든 물고기의 위치 반환
func get_possible_positions(_ array: inout [[[Int]]], _ now_x: Int, _ now_y: Int) -> [[Int]] {
    var now_x = now_x
    var now_y = now_y

    var positions = [[Int]]()
    let direction = array[now_x][now_y][1]
    // 현재의 방향으로 쭉 이동하기
    for _ in 0...3 {
        now_x += dx[direction]
        now_y += dy[direction]
        // 범위를 벗어나지 않는지 확인하며
        if 0 <= now_x && now_x < 4 && 0 <= now_y && now_y < 4 {
            // 물고기가 존재하는 경우
            if array[now_x][now_y][0] != -1 {
                positions.append([now_x, now_y])
            }
        }
    }
    return positions
}

// 모든 경우를 탐색하기 위한 DFS 함수
func dfs(_ array: [[[Int]]], _ now_x: Int, _ now_y: Int, _ total: Int) {
    var array = array // 리스트를 통째로 복사
    let total = total + array[now_x][now_y][0] // 현재 위치의 물고기 먹기
    array[now_x][now_y][0] = -1  // 물고기를 먹었으므로 번호 값을 -1로 변환

    move_all_fishes(&array, now_x, now_y)  // 전체 물고기 이동 시키기

    // 이제 다시 상어가 이동할 차례이므로, 이동 가능한 위치 찾기
    let positions = get_possible_positions(&array, now_x, now_y)

    // 이동할 수 있는 위치가 하나도 없다면 종료
    if positions.count == 0 {
        result = max(result, total)  // 최댓값 저장
        return
    }
    // 모든 이동할 수 있는 위치로 재귀적으로 수행
    for i in positions { // i[0] -> next x, i[1] -> next y
        dfs(array, i[0], i[1], total)
    }

}
// 청소년 상어의 시작 위치(0, 0)에서부터 재귀적으로 모든 경우 탐색
dfs(array, 0, 0, 0)
print(result)
