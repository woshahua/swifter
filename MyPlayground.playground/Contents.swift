import UIKit


// currying
func addTo(_ adder: Int)->(Int)->Int{
    return {
        num in
        return num + adder
    }
}

var addTwo = addTo(2)
addTwo(10)

// protocol mutating

protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    mutating func changeColor(color: UIColor)
}

struct Car: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.red
    mutating func changeColor(color: UIColor){
        self.color = color
    }
}

// inherit protocol IteratorProtocol to use for ... in
class ReverseIterator<T>: IteratorProtocol{
    typealias Element = T
    
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]){
        self.array = array
        currentIndex = array.count - 1
    }
    
    // the next one maybe nil, think about if we dont have this optional how to do
    func next() -> Element?{
        if currentIndex < 0{
            return nil
        }
        else{
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

// inherit from a ReverseSequence here
struct ReverseSequence<T>: Sequence{
    var array: [T]
    
    init(array: [T]){
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

let arr = [0, 1, 2, 3, 4]

for i in ReverseSequence(array: arr){
    print("Index \(i) is \(arr[i])")
}

// @autoclosure
func logIfTrue(_ predicate: () -> Bool){
    if predicate(){
        print("True")
    }
}

logIfTrue({return 2 > 1})
// simpler
logIfTrue({2>1})
logIfTrue{2>1}

// use @autoclosure
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate(){
        print("True")
    }
}

logIfTrue(2 > 1)

// judge nil
var level: Int?
var startLevel = 1

var currentLevel = level ?? startLevel

// @escaping
func doWork(block: ()->()) {
    block()
}

func doWorkAsync(block: @escaping ()->()) {
    DispatchQueue.main.async {
        block()
    }
}

// optional chaining

// func 修饰
//func incrementor(variable: Int)->Int {
//    return variable + 1
//}
// 没有修饰符的，默认为let
func incrementor(variable: Int) -> Int{
    return variable
}

// _ in function parameter
//func addElement(ball target: String){
//    print(target)
//}
//
//addElement(ball: "lil ball")

// so its like: variableName type: RealType
// you can do this, _ type: RealType
// why ???
func addElement(ball: String){
    print(ball)
}

addElement(ball: "lil")


