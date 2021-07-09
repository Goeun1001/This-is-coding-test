import Foundation

// 순열 코드가 이상함.. 실패 ;;
// 순열
func permuteWirth<T>(_ a: [T], _ n: Int, _ result: inout [[T]]) {
    if n == 0 {
//        print(a)   // display the current permutation
        result.append(a)
    } else {
        var a = a
        permuteWirth(a, n - 1, &result)
        for i in 0..<n {
            a.swapAt(i, n)
            permuteWirth(a, n - 1, &result)
            a.swapAt(i, n)
        }
    }
}

let n = 4 // 복도의 크기
var board = [["S", "S", "S", "T"], ["X", "X", "X", "X"],
             ["X", "X", "X", "X"], ["T", "T", "T", "X"]] // 복도 정보 (N x N)
//let n = 5 // 복도의 크기
//var board = [["X", "S", "X", "X", "T"], ["T", "X", "S", "X", "X"],
//             ["X", "X", "X", "X", "X"], ["X", "T", "X", "X", "X"],
//             ["X", "X", "T", "X", "X"]] // 복도 정보 (N x N)
var teachers = [[Int]]() // 모든 선생님 위치 정보
var spaces = [[Int]]() // 모든 빈 공간 위치 정보

for i in 0...n - 1 {
    for j in 0...n - 1 {
        // 선생님이 존재하는 위치 저장
        if board[i][j] == "T" {
            teachers.append([i, j])
        }
        // 장애물을 설치할 수 있는 (빈 공간) 위치 저장
        if board[i][j] == "X" {
            spaces.append([i, j])
        }
    }
}

// 특정 방향으로 감시를 진행 (학생 발견: True, 학생 미발견: False)
func watch(_ x: Int, _ y: Int, _ direction: Int) -> Bool {
    var x = x
    var y = y
    // 왼쪽 방향으로 감시
    if direction == 0 {
        while y >= 0 {
            if board[x][y] == "S" { // 학생이 있는 경우
                return true
            }
            if board[x][y] == "O" { // 장애물이 있는 경우
                return false
            }
            y -= 1
        }
    }
    // 오른쪽 방향으로 감시
    if direction == 1 {
        while y < n {
            if board[x][y] == "S" { // 학생이 있는 경우
                return true
            }
            if board[x][y] == "O" { // 장애물이 있는 경우
                return false
            }
            y += 1
        }
    }
    // 위쪽 방향으로 감시
    if direction == 2 {
        while x >= 0 {
            if board[x][y] == "S" { // 학생이 있는 경우
                return true
            }
            if board[x][y] == "O" { // 장애물이 있는 경우
                return false
            }
            x -= 1
        }
    }
    // 아래쪽 방향으로 감시
    if direction == 3 {
        while x < n {
            if board[x][y] == "S" { // 학생이 있는 경우
                return true
            }
            if board[x][y] == "O" { // 장애물이 있는 경우
                return false
            }
            x += 1
        }
    }
    return false
}

// 장애물 설치 이후에, 한 명이라도 학생이 감지되는지 검사
func find() -> Bool {
    for i in teachers {
        let x = i[0]
        let y = i[1]
        for j in 0...3 {
            if watch(x, y, j) {
                return true
            }
        }
    }
    return false
}
var success = false // 학생이 한 명도 감지되지 않도록 설치할 수 있는지의 여부
var result = [[[Int]]]()
permuteWirth(spaces, 3, &result)

print(result)

// 빈 공간에서 3개를 뽑는 모든 조합을 확인
for data in result {
    // 장애물들을 설치해보기
    for i in data {
        board[i[0]][i[1]] = "O" // board[x][y] = 'O'
    }
    // 학생이 한 명도 감지되지 않는 경우
    if !find() {
        success = true
        break
    }
    // 설치된 장애물을 다시 없애기
    for i in data {
        board[i[0]][i[1]] = "X"
    }
}

if success {
    print("YES")
} else {
    print("NO")
}
