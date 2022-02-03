import Foundation

// 내 풀이
func solution(_ str: String) -> Int {
    let array: [Int] = str.map { Int(String($0))! }
    var result = 0
    
    for i in array {
        if i <= 1 || result == 0 {
            result += i
        } else {
            result *= i
        }
    }
    
    return result
}

solution("02984") // 576
solution("567") // 210


// 책 풀이. 만들어질 수 있는 가장 큰 수 처리가 덜 된 듯 ..??
character = Array(n)
array = character.map { Int(String($0))! }
result = 0

for i in 1...array.count - 1 {
    // 두 수 중에서 하나라도 '0' 혹은 '1'인 경우, 곱하기보다는 더하기 수행
    let num = array[i]
    if num <= 1 || result <= 1 {
        result += num
    } else {
        result *= num
    }
}

print(result)
