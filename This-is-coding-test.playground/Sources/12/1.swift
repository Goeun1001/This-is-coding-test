import Foundation

// 내 풀이
let n = "123402"
let array = Array(n)
let count = array.count
let first = array[0...count / 2 - 1] // 이걸 굳이 만들 필요가 없었던듯~
let last = array[array.count / 2...count - 1]

var result1 = 0
var result2 = 0

for i in first {
    result1 += Int(String(i))!
}

for i in last {
    result2 += Int(String(i))!
}

if result1 == result2 {
    print("LUCKY")
} else {
    print("READY")
}

// 책 풀이
let length = array.count // 점수 값의 총 자릿수
var summary = 0 // 변수를 하나에 해놓는 굿 아이디어~

// 왼쪽 부분의 자릿수의 합 더하기
for i in 0...length / 2 - 1 {
    summary += Int(String(array[i]))!
}
// 오른쪽 부분의 자릿수의 합 빼기
for i in length / 2...length - 1 {
    summary -= Int(String(array[i]))!
}
// 왼쪽 부분과 오른쪽 부분의 자릿수 합이 동일한지 검사
if summary == 0 {
    print("LUCKY")
} else {
    print("READY")
}
