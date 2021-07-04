import Foundation

// 피보나치 함수(Fibonacci Function)을 재귀함수로 구현
func fibo(x: Int) -> Int {
    if x == 1 || x == 2 {
        return 1
    }
    return fibo(x: x - 1) + fibo(x: x - 2)
}

print(fibo(x: 4))
