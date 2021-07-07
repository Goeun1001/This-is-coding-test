import Foundation

// 뭔가.. 좀 잘못된 책풀이;;
// 혼자 풀었을만한데 꼬리랑 머리를 배열로 하는 방법은 생각도 못한듯..
let n = 10
let k = 4
var data = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1) // 맵 정보
var info = [["8", "D"], ["10", "D"], ["11", "D"], ["13", "L"]] // 방향 회전 정보
let l = 4
data[1][2] = 1
data[1][3] = 1
data[1][4] = 1
data[1][5] = 1

// 처음에는 오른쪽을 보고 있으므로(동, 남, 서, 북)
let dx = [0, 1, 0, -1]
let dy = [1, 0, -1, 0]

func turn(direction: inout Int, c: String) {
    if c == "L" {
        direction = (direction - 1) % 4
    } else {
        direction = (direction + 1) % 4
    }
}

func simulate() -> Int {
    // 뱀의 머리 위치
    var x = 1
    var y = 1
    data[x][y] = 2 // 뱀이 존재하는 위치는 2로 표시
    
    var direction = 0 // 처음에는 동쪽을 보고 있음
    var time = 0 // 시작한 뒤에 지난 '초' 시간
    var index = 0 // 다음에 회전할 정보
    var q = [[x, y]] // 뱀이 차지하고 있는 위치 정보(꼬리가 앞쪽)
    
    while true {
        let nx = x + dx[direction]
        let ny = y + dy[direction]
        
        // 맵 범위 안에 있고, 뱀의 몸통이 없는 위치라면
        if 1 <= nx && nx <= n && 1 <= ny && ny <= n && data[nx][ny] != 2 {
            // 사과가 없다면 이동 후에 꼬리 제거
            if data[nx][ny] == 0 {
                data[nx][ny] = 2
                q.append([nx, ny])
                let last = q.removeLast()
                let px = last.first!
                let py = last.last!
                data[px][py] = 0
            }
            // 사과가 있다면 이동 후에 꼬리 그대로 두기
            if data[nx][ny] == 1 {
                data[nx][ny] = 2
                q.append([nx, ny])
            }
        } else {
            // 벽이나 뱀의 몸통과 부딪혔다면
            time += 1
            break
        }
        // 다음 위치로 머리를 이동
        x = nx
        y = ny
        time += 1
        if index < l && time == Int(info[index][0])! { // 회전할 시간인 경우 회전
            turn(direction: &direction, c: info[index][1])
            index += 1
        }
    }
    return time
}

print(simulate())
