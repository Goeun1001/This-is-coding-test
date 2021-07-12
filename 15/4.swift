import Foundation

// 내 선형 풀이 (효율성 2개 통과 -> 55.0점)
//func solution(_ words:[String], _ queries:[String]) -> [Int] {
//    var result = [Int]()
//
//    for query in queries {
//        if query.hasPrefix("?") { // ? 로 시작하면
//            let q = query.count // 카운트 세기 위함
//            let qr = query.replacingOccurrences(of: "?", with: "")
//            print(q, qr)
//            var count = 0
//            for j in words {
//                if j.hasSuffix(qr) && j.count == q {
//                    count += 1
//                }
//            }
//            result.append(count)
//        } else { // ?로 끝나면
//            let q = query.count // 카운트 세기 위함
//            let qr = query.replacingOccurrences(of: "?", with: "")
////            print(q, qr)
//            var count = 0
//            for j in words {
//                if j.hasPrefix(qr) && j.count == q {
//                    count += 1
//                }
//            }
//            result.append(count)
//        }
//    }
//    return result
//}

//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"])) // [3, 2, 4, 1, 0]
//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "?????", "fr???", "fro???", "pro?"])) // [3, 6, 4, 1, 0]


// 책 풀이.. 70점 ㅋㅋㅋㅋㅋㅋㅋㅋㅋ 효율성 한문제만 더 맞음..
// 값이 [left_value, right_value]인 데이터의 개수를 반환하는 함수
//func countRange(_ a: [String], _ leftValue: String, _ rightValue: String) -> Int {
//    if a.count == 0 {
//        return 0
//    }
//    var left = 0
//    var right = a.count
//    for i in 0...a.count - 1 {
//        if a[i] >= leftValue {
//            left = i
//            break
//        }
//    }
//    for i in (0...a.count - 1).reversed() {
//        if a[i] <= rightValue {
//            right = i + 1
//            break
//        }
//    }
//    return right - left
//}
//
//func solution(_ words:[String], _ queries:[String]) -> [Int] {
//    var answer = [Int]()
//    // 모든 단어들을 길이마다 나누어서 저장하기 위한 리스트
//    var array = Array(repeating: [String](), count: 10001)
//    // 모든 단어들을 길이마다 나누어서 뒤집어 저장하기 위한 리스트
//    var reversed = Array(repeating: [String](), count: 10001)
//
//    for word in words { // 모든 단어를 접미사 와일드카드 배열, 접두사 와일드카드 배열에 각각 삽입
//        array[word.count].append(word) // 단어를 삽입
//        reversed[word.count].append(String(word.reversed())) // 단어를 뒤집어서 삽입
//    }
//
//    for i in 0...10000 { // 이진 탐색을 수행하기 위해 각 단어 리스트 정렬 수행
//        array[i].sort()
//        reversed[i].sort()
//    }
//
//    for q in queries { // 쿼리를 하나씩 확인하며 처리
//        var result = 0
//        if q.first != "?" { // 접미사에 와일드 카드가 붙은 경우
//            result = countRange(array[q.count], q.replacingOccurrences(of: "?", with: "a"), q.replacingOccurrences(of: "?", with: "z"))
//        } else { // 접두사에 와일드 카드가 붙은 경우
//            result = countRange(reversed[q.count], String(q.replacingOccurrences(of: "?", with: "a").reversed()), String(q.replacingOccurrences(of: "?", with: "z").reversed()))
//        }
//        // 검색된 단어의 개수를 저장
//        answer.append(result)
//    }
//
//    return answer
//}
//
//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"])) // [3, 2, 4, 1, 0]
//print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "?????", "fr???", "fro???", "pro?"])) // [3, 5, 4, 1, 0]


// 결국 Trie 쓴 풀이..
// https://woongsios.tistory.com/186
class TrieNode<T: Hashable> {
    var value: T?
    var count = 0
    weak var parentNode: TrieNode?
    var children = [T:TrieNode]()

    init(value: T? = nil, parentNode: TrieNode? = nil) {
        self.value = value
        self.parentNode = parentNode
    }

    func add(value: T) {
        guard children[value] == nil else { return }
        children[value] = TrieNode(value: value, parentNode: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    fileprivate let root: Node

    init() {
        root = Node()
    }
}

extension Trie {

    func childCount(query: String) -> Int {
        guard !query.isEmpty else { return 0 }

        var currentNode = root
        for char in query {
            if char == "?" {
                return currentNode.count
            }
            guard let childNode = currentNode.children[char] else {
                return 0
            }
            currentNode = childNode
        }
        return currentNode.children.count
    }

    func insert(word: String) {
        guard !word.isEmpty else { return }

        var currentNode = root
        for char in word {
            currentNode.count += 1
            if let childNode = currentNode.children[char] {
                currentNode = childNode
            } else {
                currentNode.add(value: char)
                currentNode = currentNode.children[char]!
            }
        }
    }
}

func solution(_ words:[String], _ queries:[String]) -> [Int] {
    var tries = [Int:Trie]()
    var reverseTries = [Int:Trie]()
    var result = [Int]()

    for word in words {
        if let trie = tries[word.count] {
            trie.insert(word: word)
        } else {
            tries[word.count] = Trie()
            tries[word.count]?.insert(word: word)
        }

        if let trie = reverseTries[word.count] {
            trie.insert(word: String(word.reversed()))
        } else {
            reverseTries[word.count] = Trie()
            reverseTries[word.count]?.insert(word: String(word.reversed()))
        }
    }

    for query in queries {
        let prefix = query.first == "?"
        if prefix {
            if let trie = reverseTries[query.count] {
                result.append(trie.childCount(query: String(query.reversed())))
            } else {
                result.append(0)
            }
        } else {
            if let trie = tries[query.count] {
                result.append(trie.childCount(query: query))
            } else {
                result.append(0)
            }
        }
    }
    return result
}

print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "????o", "fr???", "fro???", "pro?"])) // [3, 2, 4, 1, 0]
print(solution(["frodo", "front", "frost", "frozen", "frame", "kakao"], ["fro??", "?????", "fr???", "fro???", "pro?"])) // [3, 5, 4, 1, 0]
