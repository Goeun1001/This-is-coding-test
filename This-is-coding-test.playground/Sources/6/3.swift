import Foundation

var array = [7, 5, 9, 0, 3, 1, 6, 2, 4, 8]

for i in 1...array.count - 1 {
    for j in (1...i).reversed() { // 인덱스 i부터 1까지 1씩 감소하며 반복하는 문법
        if array[j] < array[j - 1] { // 한 칸씩 왼쪽으로 이동
            print("SWAP")
            array.swapAt(j, j - 1)
        } else {
            break
        }
    }
}

print(array)
