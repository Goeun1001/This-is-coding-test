import Foundation

// 내 풀이
let position = "a1"

func convertX(c: Character) -> Int {
    if c == "a" { return 1 }
    else if c == "b" { return 2 }
    else if c == "c" { return 3 }
    else if c == "d" { return 4 }
    else if c == "e" { return 5 }
    else if c == "f" { return 6 }
    else if c == "g" { return 7 }
    else { return 8 }
}

func convertY(c: Character) -> Int {
    return Int(String(c))!
}

var x = convertX(c: Array(position).first!)
var y = convertY(c: Array(position).last!)

// L, R, U, D에 따른 이동 방향
let dx = [2, 2, -2, -2, -1, 1, -1, 1]
let dy = [-1, 1, -1, 1, 2, 2, -2, -2]

var result = 0

// 이동 계획을 하나씩 확인
for i in 0...7 {
    // 이동 후 좌표 구하기
    let nx = x + dx[i]
    let ny = y + dy[i]

    // 공간을 벗어나는 경우 무시
    if nx < 1 || ny < 1 || nx > 8 || ny > 8 { continue }

    //  이동 수행
    result += 1
}

print(result)

// 책 풀이. 아스키코드로 그냥 할걸.. ㅠ
let row = Int(String(Array(position).last!))!
let column = Int(Array(position)[0].asciiValue!) - Int(Character("a").asciiValue!) + 1

// 나이트가 이동할 수 있는 8가지 방향 정의
let steps = [(-2, -1), (-1, -2), (1, -2), (2, -1), (2, 1), (1, 2), (-1, 2), (-2, 1)]

// 8가지 방향에 대하여 각 위치로 이동이 가능한지 확인
result = 0
for step in steps {
    // 이동하고자 하는 위치 확인
    let next_row = row + step.0
    let next_column = column + step.1
    // 해당 위치로 이동이 가능하다면 카운트 증가
    if next_row >= 1 && next_row <= 8 && next_column >= 1 && next_column <= 8 {
        result += 1
    }
}

print(result)
