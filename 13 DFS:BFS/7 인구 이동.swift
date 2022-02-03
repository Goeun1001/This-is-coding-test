// 내 풀이
let n = 3
let L = 5
let R = 10
var data = [[10, 15, 20], [20, 30, 25], [40, 22, 10]]
//let n = 2
//let L = 20
//let R = 50
//var data = [[50, 30], [20, 40]]

func check(x: Int, y: Int) -> Bool {
    if x > y {
        return L <= x - y && x - y <= R
    } else if x < y {
        return L <= y - x && y - x <= R
    } else {
        return false
    }
}

var count = 0

while true {
    var queue = Set<[Int]>() // 연합. [값, i, j]
    for i in 0...data.count - 1 { // 모든 나라의 상하좌우 확인
        // 좌. i - 1이 배열을 넘어가면 안됨
        if i - 1 > 0 && check(x: data[i][i], y: data[i][i - 1]) {
            queue.update(with: [data[i][i], i, i])
            queue.update(with: [data[i][i - 1], i, i - 1])
        }
        // 우. i + 1이 배열을 넘어가면 안됨
        if i + 1 < n && check(x: data[i][i], y: data[i][i + 1]) {
            queue.update(with: [data[i][i], i, i])
            queue.update(with: [data[i][i + 1], i, i + 1])
        }
        // 상. i - 1이 배열을 넘어가면 안됨
        if i - 1 > 0 && check(x: data[i][i], y: data[i - 1][i]) {
            queue.update(with: [data[i][i], i, i])
            queue.update(with: [data[i - 1][i], i - 1, i])
        }
        // 하. i + 1이 배열을 넘어가면 안됨
        if i + 1 < n && check(x: data[i][i], y: data[i + 1][i]) {
            queue.update(with: [data[i][i], i, i])
            queue.update(with: [data[i + 1][i], i + 1, i])
        }
    }
    var sum = 0
    if queue.isEmpty { break }
    for i in queue {
        sum += i.first! // 연합의 인구수
    }
    sum /= queue.count // 연합의 인구수 / 연합을 이루고 있는 칸의 개수
    for i in queue {
        data[i[1]][i[2]] = sum // 인구이동
    }
    count += 1
}

print(count)
