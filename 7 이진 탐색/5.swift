import Foundation

let array = [8, 3, 7, 9, 2]
let search = [5, 7, 9]

for i in search {
    if array.contains(i) {
        print("yes")
    } else {
        print("no")
    }
}
