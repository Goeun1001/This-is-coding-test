import Foundation

let number = readLine()!
var students = [String: [Int]]()
for _ in 0...Int(number)! - 1 {
    let student = readLine()!
    let array = student.components(separatedBy: " ")
    students[array.first!] = [Int(array[1])!, Int(array[2])!, Int(array[3])!]
}

for i in students.sorted(by: {
    if $0.value.first == $1.value.first {
        if $0.value[1] == $1.value[1] {
            if $0.value[2] == $1.value[2] {
                return $0.key < $1.key // 오름차순
            } else {
                return $0.value[2] > $1.value[2] // 내림차순
            }
        } else {
            return $0.value[1] < $1.value[1] // 오름차순
        }
    } else {
        return $0.value.first! > $1.value.first! // 내림차순
    }
}) {
    print(i.key)
}
