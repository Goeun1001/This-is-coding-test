import Foundation

// 내 풀이 포기
// 책 풀이

func solution(_ s:String) -> Int {
    let s = Array(s)
    var answer = s.count
    // 1개 단위(step)부터 압축 단위를 늘려가며 확인
    for step in 1...s.count / 2 + 1  {
        var compressed = ""
        var prev = s[0...step - 1] // 앞에서부터 step만큼의 문자열 추출
        var count = 1
        //  단위(step) 크기만큼 증가시키며 이전 문자열과 비교
        inner: for j in stride(from: step, to: s.count, by: step) {
            // 만약 배열의 최대 크기가 넘엇을때, 조정하기
            if j + step - 1 >= s.count {
                if count >= 2 {
                    compressed += String(count) + prev
                } else {
                    compressed += prev
                }
                prev = s[j...s.count - 1]
                count = 1
                break inner
            }
            // 이전 상태와 동일하다면 압축 횟수(count) 증가
            if prev == s[j...j + step - 1] {
                count += 1
            } else {
                // 다른 문자열이 나왔다면(더 이상 압축하지 못하는 경우라면)
                if count >= 2 {
                    compressed += String(count) + prev
                } else {
                    compressed += prev
                }
                prev = s[j...j + step - 1] // 다시 상태 초기화
                count = 1
            }
        }
        // 남아있는 문자열에 대해서 처리
        if count >= 2 {
            compressed += String(count) + prev
        } else {
            compressed += prev
        }
        // 만들어지는 압축 문자열이 가장 짧은 것이 정답
        answer = min(answer, compressed.count)
    }
    return answer
}

//print(solution("aabbaccc")) //  7
print(solution("ababcdcdababcdcd")) // 9
