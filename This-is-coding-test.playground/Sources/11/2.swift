import Foundation

// 내 풀이
let n = "02984"
var character = Array(n)
character.sort(by: { $0 > $1 })

var array = [Int]()
array = character.map { Int(String($0))! }

var result = 1

for i in stride(from: 0, to: array.count - 2, by: 2) {
    if array[i] == 0 || array[i + 1] == 0 {
        if array[i] == 0 && array[i + 1] == 0 {
            continue
        }
        result *= (array[i] + array[i + 1])
    } else {
        result *= array[i] * array[i + 1]
    }
}

if array.count % 2 == 1 {
    if array[array.count - 1] != 0 {
        result *= array[array.count - 1]
    }
}
print(result)

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
