import Foundation

// 소수 판별 함수
func is_prime_number(_ x: Int) -> Bool {
    //# 2부터 x의 제곱근까지의 모든 수를 확인하며
    for i in 2...Int(sqrt(Double(x))) {
        // x가 해당 수로 나누어떨어진다면
        if x % i == 0 {
            return false // 소수가 아님
        }
    }
    return true // 소수임
}

print(is_prime_number(4)) // 4는 소수가 아님
print(is_prime_number(7)) // 7은 소수임
