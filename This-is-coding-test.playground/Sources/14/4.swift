import Foundation

let number = Int(readLine()!)!
var cards = [Int]()
var result = 0
for i in 0...number - 1 {
    result += Int(readLine()!)!
    if i % 2 == 1 { // 짝수번째 수의 경우
        result *= 2
    }
}

print(result)
