import Foundation

let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }

//  데이터의 개수(n), 변경 횟수(m), 구간 합 계산 횟수(k)
let n = arr[0]
let m = arr[1]
let k = arr[2]
// 전체 데이터의 개수는 최대 1,000,000개
var array = Array(repeating: 0, count: n + 1)
var tree = Array(repeating: 0, count: n + 1)

// i번째 수까지의 누적 합을 계산하는 함수
func prefix_sum(i: Int) -> Int {
    var result = 0
    var i = i
    while i > 0 {
        result += tree[i]
        // 0이 아닌 마지막 비트만큼 빼가면서 이동
        i -= (i & -i)
    }
    return result
}

// i번째 수를 dif만큼 더하는 함수
func update(i: Int, dif: Int) {
    var i = i
    while i <= n {
        tree[i] += dif
        i += (i & -i)
    }
}

// start부터 end까지의 구간 합을 계산하는 함수
func interval_sum(start: Int, end: Int) -> Int {
    return prefix_sum(i: end) - prefix_sum(i: start - 1)
}

for i in 1...n {
    let x = Int(readLine()!)!
    array[i] = x
    update(i: i, dif: x)
}

for _ in 1...m + k {
    let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = arr[0]
    let b = arr[1]
    let c = arr[2]

    // 업데이트(update) 연산인 경우
    if a == 1 {
        update(i: b, dif: c - array[b]) // 바뀐 크기(dif)만큼 적용
        array[b] = c
    } else {
        // 구간 합(interval sum) 연산인 경우
        print(interval_sum(start: b, end: c))
    }
}
