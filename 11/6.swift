import Foundation

// 내 풀이 - 1, 2, 16, 19, 20, 23, 30, 31, 32 / 효율성 2 통과 ㅋㅋ ㅠㅠ 아마 -1 때문에 맞은게 절반인듯
func solution(_ food_times:[Int], _ k:Int64) -> Int {
    let k = Int(k)
    // 전체 음식을 먹는 시간보다 k가 크거나 같다면 -1
    if food_times.reduce(0, +) <= k {
        return -1
    }

    let count = food_times.count // 3
    var result = k % count  // 2
    var food = food_times // [3, 1, 2]

    print(food)
    print("result = \( k % count )")

    for i in 0...count - 1 { // 이부분이 좀 잘못된듯;;
        if result == 0 {
            food[i] -= k / count
        } else if i <= result - 1 {
            food[i] -= k / count + 1
        } else {
            food[i] -= k / count
        }
    }

    print(food)

    for i in 0...count - 1 {
        if food[i] < 0 {
            result += -(food[i])
        }
    }

    return result % count + 1
}

print(solution([3, 1, 2], 5)) // expects 1
//print(solution([4,2,3,6,7,1,5,8], 16)) // expects 3
//print(solution([1, 5, 5, 5, 5, 6, 7], 31)) // expects 6
//print(solution([7,8,3,3,2,2,2,2,2,2,2,2], 35)) // expects 2
print(solution([4, 3, 5, 6, 2], 7)) // expects 3

public struct PriorityQueue<Element: Equatable> {
    public var elements: [[Element]] = []
    var sort: ([Element], [Element]) -> Bool

    public init(sort: @escaping ([Element], [Element]) -> Bool, elements: [[Element]] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }

    public var isEmpty: Bool {
        return elements.isEmpty
    }

    public var peek: [Element]? {
        return elements.first
    }

    public mutating func enqueue(element: [Element]) -> Bool {
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }

    public mutating func dequeue() -> [Element]? {
        isEmpty ? nil : elements.removeFirst()
    }

    public mutating func resort() {
        elements.sort(by: sort)
    }

}


func solution(_ food_times:[Int], _ k:Int64) -> Int {
    // 전체 음식을 먹는 시간보다 k가 크거나 같다면 -1
    if food_times.reduce(0, +) <= k {
        return -1
    }

    // 시간이 작은 음식부터 빼야 하므로 우선순위 큐를 이용
    var queue = PriorityQueue(sort: { $0.first! < $1.first! }, elements: [[Int]]())
    //    q = []
    for i in 0...food_times.count - 1 {
        // (음식 시간, 음식 번호) 형태로 우선순위 큐에 삽입
        queue.enqueue(element: [food_times[i], i + 1])
    }

    var sum_value = 0 // 먹기 위해 사용한 시간
    var previous = 0 // 직전에 다 먹은 음식 시간
    var length = food_times.count // 남은 음식의 개수

    // sum_value + (현재의 음식 시간 - 이전 음식 시간) * 현재 음식 개수와 k 비교
    while sum_value + ((queue.elements[0][0] - previous) * length) <= k {
        let now = queue.dequeue()![0]
        sum_value += (now - previous) * length
        length -= 1 // 다 먹은 음식 제외
        previous = now // 이전 음식 시간 재설정
    }


    //  남은 음식 중에서 몇 번째 음식인지 확인하여 출력
    queue.sort = { $0.last! < $1.last! }
    queue.resort() // 음식의 번호 기준으로 정렬
    let result = queue.elements
    return result[(Int(k) - sum_value) % length][1]
}

print(solution([3, 1, 2], 5)) // expects 1
