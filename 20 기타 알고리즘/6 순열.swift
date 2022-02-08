import Foundation

func permute<T>(_ target: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    var visited = Array(repeating: false, count: target.count)
    
    func permutation(_ temp: [T]) {
        if temp.count == targetNum {
            result.append(temp)
            return
        }
        for i in 0..<target.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                permutation(temp + [target[i]])
                visited[i] = false
            }
        }
    }
    
    permutation([])
    
    return result
}

print(permute([1, 2, 3], 2))
