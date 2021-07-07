import Foundation

// 내 풀이..는없다;;
// 책 풀이는 swift만 50점 ㅠㅠ 다른 사람 풀이도 비슷하니까 다음에 다시 풀 때 스스로 구현하는게 좋을 듯!
// 2차원 리스트 90도 회전하기
func rotate(a: [[Int]]) -> [[Int]] {
    let n = a.count // 행 길이 계산
    let m = a[0].count // 열 길이 계산
    var result = Array(repeating: Array(repeating: 0, count: m), count: n)
    for i in 0...n - 1 {
        for j in 0...m - 1 {
            result[j][n - i - 1] = a[i][j]
        }
    }
    return result
}

// 자물쇠의 중간 부분이 모두 1인지 확인
func check(lock: [[Int]]) -> Bool {
    let length = lock.count / 3
    for i in length...length * 2 - 1 {
        for j in length...length * 2 - 1 {
            if lock[i][j] != 1 {
                return false
            }
        }
    }
    return true
}

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    let n = lock.count
    let m = key.count
    // 자물쇠의 크기를 기존의 3배로 변환
    var newLock = Array(repeating: Array(repeating: 0, count: n * 3), count: n * 3)
    // 새로운 자물쇠의 중앙 부분에 기존의 자물쇠 넣기
    for i in 0...n - 1 {
        for j in 0...n - 1 {
            newLock[i + n][j + n] = lock[i][j]
        }
    }

    // 4가지 방향에 대해서 확인
    for rotation in 0...3 {
        let key = rotate(a: key) // 열쇠 회전
        for x in 0...n * 2 - 1 {
            for y in 0...n * 2 - 1 {
                var lock = newLock
                // 자물쇠에 열쇠를 끼워 넣기
                for i in 0...m - 1 {
                    for j in 0...m - 1 {
                        lock[x + i][y + j] += key[i][j]
                    }
                }
                // 새로운 자물쇠에 열쇠가 정확히 들어 맞는지 검사
                if check(lock: lock) == true {
                    return true
                }
            }
        }
    }
    return false
}

print(solution([[0, 0, 0], [1, 0, 0], [0, 1, 1]], [[1, 1, 1], [1, 1, 0], [1, 0, 1]])) // true
