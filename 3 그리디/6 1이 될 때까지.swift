import Foundation

var n = 25
var k = 3
var result = 0

// N이 K 이상이라면 K로 계속 나누기
while true {
    // N이 K로 나누어 떨어지지 않는다면 N에서 1씩 빼기
    let target = (n / k) * k
    result += (n - target)
    n = target
    // N이 K보다 작을 때 (더 이상 나눌 수 없을 때) 반복문 탈출
    if n < k { break }
    // K로 나누기
    result += 1
    n /= k
}

// 마지막으로 남은 수에 대하여 1씩 빼기
result += (n - 1)
print(result)