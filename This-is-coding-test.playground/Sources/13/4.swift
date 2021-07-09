import Foundation

// 내 풀이..는 균형잡힌 괄호 문자열을 어떻게 판변할지 몰랐는데 count라는 변수라니.. ㅠ
// 책 풀이
// "균형잡힌 괄호 문자열"의 인덱스 반환
func balancedIndex(p: String) -> Int {
    let p = Array(p)
    var count = 0 //왼쪽 괄호의 개수
    for i in 0...p.count - 1 {
        if p[i] == "(" {
            count += 1
        } else {
            count -= 1
        }
        if count == 0 {
            return i
        }
    }
    return -1
}
// "올바른 괄호 문자열"인지 판단
func checkCorrect(p: String) -> Bool {
    let p = Array(p)
    var count = 0 // 왼쪽 괄호의 개수
    for i in p {
        if i == "(" {
            count += 1
        } else {
            if count == 0 { // 쌍이 맞지 않는 경우에 False 반환
                return false
            }
            count -= 1
        }
    }
    return true // 쌍이 맞는 경우에 True 반환
}

func solution(_ p:String) -> String {
    var answer = ""
    if p == "" { // 1. 입력이 빈 문자열인 경우, 빈 문자열을 반환합니다.
        return answer
    }
    let array = Array(p)
    let index = balancedIndex(p: p)
    // 문자열 w를 두 "균형잡힌 괄호 문자열" u, v로 분리합니다.
    // 단, u는 "균형잡힌 괄호 문자열"로 더 이상 분리할 수 없어야 하며, v는 빈 문자열이 될 수 있습니다.
    var u = array[0...index]
    var v = ""
    if index + 1 < p.count {
        v = String(array[index + 1...p.count - 1])
    }
    
    if checkCorrect(p: String(u)) {
        // 3. 문자열 u가 "올바른 괄호 문자열" 이라면 문자열 v에 대해 1단계부터 다시 수행합니다.
        // 3-1. 수행한 결과 문자열을 u에 이어 붙인 후 반환합니다.
        answer = u + solution(v)
    } else {
        // 4. 문자열 u가 "올바른 괄호 문자열"이 아니라면 아래 과정을 수행합니다.
        answer = "(" // 4-1. 빈 문자열에 첫 번째 문자로 '('를 붙입니다.
        // 4-2. 문자열 v에 대해 1단계부터 재귀적으로 수행한 결과 문자열을 이어 붙입니다.
        answer += solution(v)
        // 4-3. ')'를 다시 붙입니다.
        answer += ")"
        //4-4. u의 첫 번째와 마지막 문자를 제거하고
        u.removeFirst()
        u.removeLast()
        // 나머지 문자열의 괄호 방향을 뒤집어서 뒤에 붙입니다.
        if !u.isEmpty {
            for i in u.indices {
                if u[i] == "(" {
                    u[i] = ")"
                } else {
                    u[i] = "("
                }
            }
        }
        // 5. 생성된 문자열을 반환합니다.
        answer += String(u)
    }
    
    return answer
}

print(solution("(()())()")) // "(()())()"
print(solution(")(")) // "()"
print(solution("()))((()")) // "()(())()"
