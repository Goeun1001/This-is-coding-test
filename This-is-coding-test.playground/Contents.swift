import Foundation

let a = Int(readLine()!)!
let b = Int(readLine()!)!
let c = Int(readLine()!)!
let d = Int(readLine()!)!
let e = Int(readLine()!)!

let average = (Double(a) + Double(b) + Double(c) + Double(d) + Double(e)) / 5.0
print(trunc(average))

func customPrint(number: Int) {
    if 0 <= number && number <= 10 {
        print(number, "프로그래밍 기초반")
    } else if 10 < number && number < 45 {
        print(number, "프로그래밍반")
    } else {
        print(number, "다른 방과후 수업")
    }
}

customPrint(number: a)
customPrint(number: b)
customPrint(number: c)
customPrint(number: d)
customPrint(number: e)
