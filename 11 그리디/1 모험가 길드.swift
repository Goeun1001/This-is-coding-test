import Foundation

func solution(_ n: Int, _ people: [Int]) -> Int {
    var result = 0
    
    var people = people.sorted() // [1, 2, 2, 2, 3]
    people.insert(0, at: 0) // [0, 1, 2, 2, 2, 3]
    var i = 1
    
    while i <= people.count {
        if i * 2 >= people.count {
            break
        }
        result += 1
        i += i
    }
    
    return result
}

solution(5, [2, 3, 1, 2, 2]) // expect 2
