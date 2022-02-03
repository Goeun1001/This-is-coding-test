import Foundation

let n = 5
let m = 8
let k = 3

var data = [2, 4, 5, 4, 6]
data.sort() // 입력 받은 수들 정렬하기
let first = data[n - 1] // 가장 큰 수
let second = data[n - 2] // 두 번째로 큰 수

// 가장 큰 수가 더해지는 횟수 계산

/**
 수열이 반복되는 횟수 : M / (K+1)
 */
var count = Int(m / (k + 1)) * k
count += m % (k + 1)

var result = 0
result += (count) * first // 가장 큰 수 더하기
result += (m - count) * second // 두 번째로 큰 수 더하기

print(result) // 최종 답안 출력
