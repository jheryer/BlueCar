
import SwiftUI

let MAX_VALUE = 255.0
let MIN_VALUE = 0.0

struct BasicMotorControl: View {
    let name:String
    @State var controlValue = 0.0
    
    var body: some View {
        VStack {
            Button(action: {
                controlValue = MIN_VALUE
            }) {
                Text("Off")
            }
            BasicSlider(value: $controlValue)
            Button(action: {
                controlValue = MAX_VALUE
            }) {
                Text("On")
            }
        }
    }
}

struct BasicControl_Previews: PreviewProvider {
    static var previews: some View {
        BasicMotorControl(name: "test")
    }
}
