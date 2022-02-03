import Foundation

// 내 풀이
var player = [1, 1, 0] // 0: 북쪽, 1: 동쪽, 2: 남쪽, 3: 서쪽
var map = [[1, 1, 1, 1], [1, 0, 0, 1], [1, 1, 0, 1], [1, 1, 1, 1]] // 0: 방문 가능, 1: 방문 불가능

var result = 1

map[player[0]][player[1]] = 1 // 처음 배치된 곳은 이미 가있다고 바꿔주기

func checkBeforeGo() -> Bool {
    print(player)
    if player[2] == 1 { // 동쪽일 때, 북쪽 보기
        return map[player[0] - 1][player[1]] == 0
    } else  if player[2] == 2 { // 남쪽일 때, 동쪽 보기
        return map[player[0]][player[1] + 1] == 0
    } else  if player[2] == 3 { // 서쪽일 때, 남쪽 보기
        return map[player[0] + 1][player[1]] == 0
    } else  if player[2] == 0 { // 북쪽일 때, 서쪽 보기
        return map[player[0]][player[1] - 1] == 0
    }
    return false
}

@discardableResult
func goBack() -> Bool {
    if player[2] == 0 { // 북쪽이니까 남쪽으로 이동
        if map[player[0]][player[1]-1] == 1 {
            return false
        } else {
            player[0] += 1
        }
    } else if player[2] == 1 { // 동쪽이니까 서쪽으로 이동
        if map[player[0]-1][player[1]] == 1 {
            return false
        } else {
            player[1] -= 1
        }
    } else  if player[2] == 2 { // 남쪽이니까 북쪽으로 이동
        if map[player[0]][player[1]+1] == 1 {
            return false
        } else {
            player[0] -= 1
        }
    } else { // 서쪽이니까 동쪽으로 이동
        if map[player[0]+1][player[1]] == 1 {
            return false
        } else {
            player[1] += 1
        }
    }
    return true
}

func checkImpossible() -> Bool {
    return map[player[0] - 1][player[1]] > 0
        && map[player[0]][player[1] + 1] > 0
        && map[player[0] + 1][player[1]] > 0
        && map[player[0]][player[1] - 1] > 0
}

func turnLeft() {
    if player[2] == 0 {
        player[2] = 3
    } else {
        player[2] -= 1
    }
}

func go() {
    result += 1
    if player[2] == 0 { // 북쪽으로 이동
        map[player[0]][player[1]] = 1
        player[0] -= 1
    } else if player[2] == 1 { // 동쪽으로 이동
        map[player[0]][player[1]] = 1
        player[1] += 1
    } else  if player[2] == 2 { // 남쪽으로 이동
        map[player[0]][player[1]] = 1
        player[0] += 1
    } else { // 서쪽으로 이동
        map[player[0]][player[1]] = 1
        player[1] -= 1
    }
}

while true {
    if !checkBeforeGo() {
        print("Turn Left")
        turnLeft()
    } else {
        print("Go")
        turnLeft()
        go()
    }

    if checkImpossible() {
        if !goBack() {
            break
        }
    }
}

print(result)

// 책 풀이는 없습니다.
