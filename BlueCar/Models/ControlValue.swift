import Foundation

struct ControlValue: Equatable {
    let name: String
    let value:Int
    
    static func ==(lhs: ControlValue, rhs: ControlValue)-> Bool {
        return lhs.name == rhs.name && lhs.value == rhs.value
    }
}
