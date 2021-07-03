import Foundation

// 내 풀이
let count = 5
let array = ["R", "R", "R", "U", "D", "D"]
var position = [1, 1]

func move(c: String) {
    if c == "L" {
        if position[1] != 1 { position[1] -= 1 }
    } else if c == "R" {
        if position[1] != count { position[1] += 1 }
    } else if c == "U" {
        if position[0] != 1 { position[0] -= 1 }
    } else if c == "D" {
        if position[0] != count { position[0] += 1 }
    }
}

for i in array {
    move(c: i)
}

print(position[0], position[1])

// 책 풀이. 배열로 이렇게 더하고 빼는거 좋은 거 같다.
var x = 1
var y = 1

// L, R, U, D에 따른 이동 방향
let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]
let moveTypes = ["L", "R", "U", "D"]

// 이동 계획을 하나씩 확인
for plan in array {
    // 이동 후 좌표 구하기
    var nx = 0
    var ny = 0
    for i in moveTypes.indices {
        if plan == moveTypes[i] {
            nx = x + dx[i]
            ny = y + dy[i]
        }
    }

    // 공간을 벗어나는 경우 무시
    if nx < 1 || ny < 1 || nx > count || ny > count { continue }

    //  이동 수행
    x = nx
    y = ny
}

print(x, y)
