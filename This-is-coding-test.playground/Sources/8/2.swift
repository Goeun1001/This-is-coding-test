import Foundation

// 한 번 계산된 결과를 메모이제이션(Memoization)하기 위한 리스트 초기화
var d = Array(repeating: 0, count: 100)

// 피보나치 함수(Fibonacci Function)를 재귀함수로 구현 (탑다운 다이나믹 프로그래밍)
func fibo(x: Int) -> Int {
    // 종료 조건(1 혹은 2일 때 1을 반환)
    if x == 1 || x == 2 {
        return 1
    }
    // 이미 계산한 적 있는 문제라면 그대로 반환
    if d[x] != 0 {
        return d[x]
    }
    // 아직 계산하지 않은 문제라면 점화식에 따라서 피보나치 결과 반환
    d[x] = fibo(x: x - 1) + fibo(x: x - 2)
    return d[x]
}

print(fibo(x: 4))
