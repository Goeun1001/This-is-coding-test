import Foundation

// 내 선형 풀이 (효율성 2개 통과 -> 55.0점)
// Trie 풀이
class TrieNode<Value: Hashable> {
    var value: Value?
    weak var parent: TrieNode?
    var children = [Value: TrieNode]()
    var childrenCount = 0
    
    init(value: Value? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    
    let root: Node = Node()
    
    func insert(value: String) {
        var current: Node = root
        
        for char in value {
            if current.children[char] != nil {
                current.childrenCount += 1
                current = current.children[char]!
            } else {
                current.childrenCount += 1
                current.children[char] = Node(value: char, parent: current)
                current = current.children[char]!
            }
        }
    }
    
    func count(prefix: String) -> Int {
        var current: Node = root
        
        for char in prefix {
            if char == "?" { return current.childrenCount }
            
            if current.children[char] != nil { // 자식이 있으면
                current = current.children[char]!
            } else { // 자식이 없으면
                return 0
            }
        }
        
        return 0
    }
}

// Trie 트리
func solution(_ words:[String], _ queries:[String]) -> [Int] {
    var tries = [Int: Trie]()
    var reversedTries = [Int: Trie]()
    var result = [Int]()
    
    // 1. 단어 집어넣기
    for word in words {
        if tries[word.count] != nil {
            tries[word.count]!.insert(value: word)
        } else {
            tries[word.count] = Trie()
            tries[word.count]!.insert(value: word)
        }
        
        let reversedWord = String(word.reversed())
        if reversedTries[word.count] != nil {
            reversedTries[word.count]!.insert(value: reversedWord)
        } else {
            reversedTries[word.count] = Trie()
            reversedTries[word.count]!.insert(value: reversedWord)
        }
    }
    
    // 2. 단어 수 세기
    for query in queries {
        if !query.starts(with: "?") {
            if let trie = tries[query.count] {
                result.append(trie.count(prefix: query))
            } else {
                result.append(0)
            }
        } else {
            let reversedQuery = String(query.reversed())
            if let trie = reversedTries[query.count] {
                result.append(trie.count(prefix: reversedQuery))
            } else {
                result.append(0)
            }
        }
    }
    
    return result
}

//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"])) // [3, 2, 4, 1, 0]
//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "?????", "fr???", "fro???", "pro?"])) // [3, 6, 4, 1, 0]


// 책 풀이. 호율성 2문제 틀려서 70점
// 값이 [left_value, right_value]인 데이터의 개수를 반환하는 함수
func countRange(_ a: [String], _ leftValue: String, _ rightValue: String) -> Int {
    if a.count == 0 {
        return 0
    }
    var left = 0
    var right = a.count
    for i in 0...a.count - 1 {
        if a[i] >= leftValue {
            left = i
            break
        }
    }
    for i in (0...a.count - 1).reversed() {
        if a[i] <= rightValue {
            right = i + 1
            break
        }
    }
    return right - left
}

func solution(_ words:[String], _ queries:[String]) -> [Int] {
    var answer = [Int]()
    // 모든 단어들을 길이마다 나누어서 저장하기 위한 리스트
    var array = Array(repeating: [String](), count: 10001)
    // 모든 단어들을 길이마다 나누어서 뒤집어 저장하기 위한 리스트
    var reversed = Array(repeating: [String](), count: 10001)

    for word in words { // 모든 단어를 접미사 와일드카드 배열, 접두사 와일드카드 배열에 각각 삽입
        array[word.count].append(word) // 단어를 삽입
        reversed[word.count].append(String(word.reversed())) // 단어를 뒤집어서 삽입
    }
    
    for i in array.indices { // 이진 탐색을 수행하기 위해 각 단어 리스트
        array[i].sort()
        reversed[i].sort()
    }

    for q in queries { // 쿼리를 하나씩 확인하며 처리
        var result = 0
        if q.first != "?" { // 접미사에 와일드 카드가 붙은 경우
            result = countRange(array[q.count], q.replacingOccurrences(of: "?", with: "a"), q.replacingOccurrences(of: "?", with: "z"))
        } else { // 접두사에 와일드 카드가 붙은 경우
            result = countRange(reversed[q.count], String(q.replacingOccurrences(of: "?", with: "a").reversed()), String(q.replacingOccurrences(of: "?", with: "z").reversed()))
        }
        // 검색된 단어의 개수를 저장
        answer.append(result)
    }

    return answer
}

print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"])) // [3, 2, 4, 1, 0]
print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "?????", "fr???", "fro???", "pro?"])) // [3, 5, 4, 1, 0]

